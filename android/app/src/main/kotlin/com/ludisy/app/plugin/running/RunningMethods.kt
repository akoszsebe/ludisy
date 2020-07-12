package com.ludisy.app.plugin.running

import android.content.Context
import com.google.gson.Gson
import com.ludisy.app.plugin.WorkoutMethodCalls
import com.ludisy.app.plugin.data.AppDatabase
import com.ludisy.app.plugin.data.model.RunningObj
import com.ludisy.app.plugin.running.RunningForegroundService
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class RunningMethods(private val context: Context) : WorkoutMethodCalls<RunningObj> {
    override fun checkMethodCalls(appDatabase: AppDatabase, call: MethodCall, result: MethodChannel.Result) {
        if (call.method.equals("running/start")) {
            RunningForegroundService.startService(context, "Have fun")
            result.success(true)
        } else if (call.method.equals("running/stop")) {
            RunningForegroundService.stopService(context)
            result.success(true)
        } else if (call.method.equals("running/getdata")) {
            getAllData(appDatabase)
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeOn(Schedulers.io())
                    .subscribe({ resultList ->
                        val toJson = Gson().toJson(resultList)
                        result.success(toJson)
                    }, {
                        result.success(null);
                    })
        } else if (call.method.equals("running/removedata")) {
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

    override fun getAllData(appDatabase: AppDatabase): Single<List<RunningObj>> {
        return Single.create<List<RunningObj>> { emitter: SingleEmitter<List<RunningObj>> ->
            try {
                var runningObjList = appDatabase.runningDao().getAll()
                emitter.onSuccess(runningObjList)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }

    override fun removeAllData(appDatabase: AppDatabase): Single<Unit> {
        return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
            try {
                appDatabase.runningDao().deleteAll()
                emitter.onSuccess(Unit)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }

}