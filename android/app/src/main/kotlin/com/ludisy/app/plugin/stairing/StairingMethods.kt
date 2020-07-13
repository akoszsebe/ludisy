package com.ludisy.app.plugin.stairing

import android.content.Context
import com.google.gson.Gson
import com.ludisy.app.plugin.WorkoutMethodCalls
import com.ludisy.app.plugin.data.AppDatabase
import com.ludisy.app.plugin.data.model.StairingObj
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class StairingMethods(private val context: Context) : WorkoutMethodCalls<StairingObj> {
    override fun checkMethodCalls(appDatabase: AppDatabase, call: MethodCall, result: MethodChannel.Result) {
        if (call.method.equals("stairing/start")) {
            StairingForegroundService.startService(context, "Have fun")
            result.success(true)
        } else if (call.method.equals("stairing/stop")) {
            StairingForegroundService.stopService(context)
            result.success(true)
        } else if (call.method.equals("stairing/getdata")) {
            getAllData(appDatabase)
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeOn(Schedulers.io())
                    .subscribe({ resultList ->
                        val toJson = Gson().toJson(resultList)
                        result.success(toJson)
                    }, {
                        result.success(null);
                    })
        } else if (call.method.equals("stairing/removedata")) {
            removeAllData(appDatabase)
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeOn(Schedulers.io())
                    .subscribe({
                        result.success(true)
                    }, {
                        result.success(false)
                    })

        }
    }

    override fun getAllData(appDatabase: AppDatabase): Single<List<StairingObj>> {
        return Single.create<List<StairingObj>> { emitter: SingleEmitter<List<StairingObj>> ->
            try {
                var runningObjList = appDatabase.stairingDao().getAll()
                emitter.onSuccess(runningObjList)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }

    override fun removeAllData(appDatabase: AppDatabase): Single<Unit> {
        return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
            try {
                appDatabase.stairingDao().deleteAll()
                emitter.onSuccess(Unit)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }
}