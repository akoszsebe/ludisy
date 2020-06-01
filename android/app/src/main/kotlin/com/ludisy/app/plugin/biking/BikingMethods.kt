package com.ludisy.app.plugin.biking

import android.content.Context
import com.google.gson.Gson
import com.ludisy.app.plugin.WorkoutMethodCalls
import com.ludisy.app.plugin.data.AppDatabase
import com.ludisy.app.plugin.data.model.BikingObj
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class BikingMethods(private val context:Context) : WorkoutMethodCalls<BikingObj>{

    override fun checkMethodCalls(appDatabase: AppDatabase, call: MethodCall, result: MethodChannel.Result){
        if (call.method.equals("biking/start")) {
            BikingForegroundService.startService(context, "Have fun")
            result.success(true)
        } else if (call.method.equals("biking/stop")) {
            BikingForegroundService.stopService(context)
            result.success(true)
        } else if (call.method.equals("biking/getdata")) {
            getAllData(appDatabase)
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeOn(Schedulers.io())
                    .subscribe({ resultList ->
                        val toJson = Gson().toJson(resultList)
                        result.success(toJson)
                    }, {
                        result.success(null);
                    })
        } else if (call.method.equals("biking/removedata")) {
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

    override fun getAllData(appDatabase: AppDatabase): Single<List<BikingObj>> {
        return Single.create<List<BikingObj>> { emitter: SingleEmitter<List<BikingObj>> ->
            try {
                var bikingObjList = appDatabase.bikingDao().getAll()
                emitter.onSuccess(bikingObjList)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }

    override fun removeAllData(appDatabase: AppDatabase): Single<Unit> {
        return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
            try {
                appDatabase.bikingDao().deleteAll()
                emitter.onSuccess(Unit)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }
}