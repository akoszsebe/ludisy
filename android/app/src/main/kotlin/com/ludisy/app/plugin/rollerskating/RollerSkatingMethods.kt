package com.ludisy.app.plugin.rollerskating

import android.content.Context
import com.google.gson.Gson
import com.ludisy.app.plugin.WorkoutMethodCalls
import com.ludisy.app.plugin.rollerskating.RollerSkatingForegroundService
import com.ludisy.app.plugin.data.AppDatabase
import com.ludisy.app.plugin.data.model.RollerSkatingObj
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class RollerSkatingMethods(private val context: Context) : WorkoutMethodCalls<RollerSkatingObj>{
    override fun checkMethodCalls(appDatabase: AppDatabase, call: MethodCall, result: MethodChannel.Result) {
        if (call.method.equals("rollerskating/start")) {
            RollerSkatingForegroundService.startService(context, "Have fun")
            result.success(true)
        } else if (call.method.equals("rollerskating/stop")) {
            RollerSkatingForegroundService.stopService(context)
            result.success(true)
        } else if (call.method.equals("rollerskating/getdata")) {
            getAllData(appDatabase)
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeOn(Schedulers.io())
                    .subscribe({ resultList ->
                        val toJson = Gson().toJson(resultList)
                        result.success(toJson)
                    }, {
                        result.success(null);
                    })
        } else if (call.method.equals("rollerskating/removedata")) {
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

    override fun getAllData(appDatabase: AppDatabase): Single<List<RollerSkatingObj>> {
        return Single.create<List<RollerSkatingObj>> { emitter: SingleEmitter<List<RollerSkatingObj>> ->
            try {
                var rollerSkatingObjList = appDatabase.rollerSkatingDao().getAll()
                emitter.onSuccess(rollerSkatingObjList)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }

    override fun removeAllData(appDatabase: AppDatabase): Single<Unit> {
        return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
            try {
                appDatabase.rollerSkatingDao().deleteAll()
                emitter.onSuccess(Unit)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }

}