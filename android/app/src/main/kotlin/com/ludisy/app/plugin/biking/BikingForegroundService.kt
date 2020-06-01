package com.ludisy.app.plugin.biking

import android.content.Context
import android.content.Intent
import androidx.core.content.ContextCompat
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationResult
import com.ludisy.app.plugin.ForegroundService
import com.ludisy.app.plugin.data.model.BikingObj
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.schedulers.Schedulers


class BikingForegroundService : ForegroundService() {
    companion object {
        fun startService(context: Context, message: String) {
            val startIntent = Intent(context, BikingForegroundService::class.java)
            startIntent.putExtra("inputExtra", message)
            ContextCompat.startForegroundService(context, startIntent)
        }

        fun stopService(context: Context) {
            val stopIntent = Intent(context, BikingForegroundService::class.java)
            context.stopService(stopIntent)
        }
    }

    override fun getNotificationName(): String {
       return "Ludicy Biking"
    }

    override var locationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult) {
            if (locationResult.lastLocation != null) {
                locationHelper.stopLocationUpdates(this)
                println(locationResult.toString())
                var bikingObj = BikingObj(
                        null,
                        locationResult.lastLocation.longitude,
                        locationResult.lastLocation.latitude,
                        locationResult.lastLocation.altitude,
                        locationResult.lastLocation.speed,
                        System.currentTimeMillis()
                )
                disposable = saveData(bikingObj).subscribeOn(Schedulers.io())
                        .subscribe()
            }
        }

        fun saveData(bikingObj: BikingObj): Single<Unit> {
            return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
                try {
                    var id = appDatabase?.bikingDao()?.insert(bikingObj)
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