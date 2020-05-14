package com.ludisy.app

import androidx.annotation.NonNull;
import androidx.room.Room
import com.google.gson.Gson
import com.ludisy.app.plugin.ForegroundService
import com.ludisy.app.plugin.data.AppDatabase
import com.ludisy.app.plugin.data.model.BikingObj
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.app.ludisy/workout"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val appDatabase = Room.databaseBuilder(
                applicationContext,
                AppDatabase::class.java, "workout_database"
        ).build()
        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method.equals("startBiking")) {
                        ForegroundService.startService(this, "Have fun")
                        result.success(true)
                    } else if (call.method.equals("stopBiking")) {
                        ForegroundService.stopService(this)
                        result.success(true)
                    } else if (call.method.equals("getBikingdata")) {
                        getBikingDataAll(appDatabase)
                                .observeOn(AndroidSchedulers.mainThread())
                                .subscribeOn(Schedulers.io())
                                .subscribe({ resultList ->
                                    val toJson = Gson().toJson(resultList)
                                    println("Android nativ print " + toJson);
                                    result.success(toJson)
                                }, {
                                    println("Android nativ print " + it);
                                    result.success(null);
                                })
                    } else if (call.method.equals("removeBikingdata")) {
                        removeBikingDataAll(appDatabase)
                                .observeOn(AndroidSchedulers.mainThread())
                                .subscribeOn(Schedulers.io())
                                .subscribe({ resultList ->
                                    result.success(true)
                                }, {
                                    println("Android nativ print " + it);
                                    result.success(false)
                                })

                    }
                }
    }

    fun getBikingDataAll(appDatabase: AppDatabase): Single<List<BikingObj>> {
        return Single.create<List<BikingObj>> { emitter: SingleEmitter<List<BikingObj>> ->
            try {
                var bikingObjList = appDatabase?.bikingDao()?.getAll()
                emitter.onSuccess(bikingObjList)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }

    fun removeBikingDataAll(appDatabase: AppDatabase): Single<Unit> {
        return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
            try {
                appDatabase?.bikingDao()?.deleteAll()
                emitter.onSuccess(Unit)
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }
}
