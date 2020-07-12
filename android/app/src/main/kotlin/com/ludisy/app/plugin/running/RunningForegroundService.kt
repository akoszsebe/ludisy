package com.ludisy.app.plugin.running

import android.content.Context
import android.content.Intent
import androidx.core.content.ContextCompat
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationResult
import com.ludisy.app.plugin.ForegroundService
import com.ludisy.app.plugin.data.model.RunningObj
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.schedulers.Schedulers

class RunningForegroundService : ForegroundService(){
    override fun getNotificationName(): String {
        return "Ludisy Running"
    }

    companion object {
        fun startService(context: Context, message: String) {
            val startIntent = Intent(context, RunningForegroundService::class.java)
            startIntent.putExtra("inputExtra", message)
            ContextCompat.startForegroundService(context, startIntent)
        }

        fun stopService(context: Context) {
            val stopIntent = Intent(context, RunningForegroundService::class.java)
            context.stopService(stopIntent)
        }
    }

    override var locationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult) {
            if (locationResult.lastLocation != null) {
                locationHelper.stopLocationUpdates(this)
                println(locationResult.toString())
                var runningObj = RunningObj(
                        null,
                        locationResult.lastLocation.longitude,
                        locationResult.lastLocation.latitude,
                        locationResult.lastLocation.speed,
                        0,
                        System.currentTimeMillis()
                )
                disposable = saveData(runningObj).subscribeOn(Schedulers.io())
                        .subscribe()
            }
        }

        fun saveData(runningObj: RunningObj): Single<Unit> {
            return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
                try {
                    var id = appDatabase?.runningDao()?.insert(runningObj)
                    if (id!=null){
                        emitter.onSuccess(Unit);
                    } else{
                        emitter.onError(NullPointerException())
                    }
                } catch (e: Exception){
                    emitter.onError(e)
                }
            }
        }
    }

}