package com.ludisy.app.plugin.rollerskating

import android.content.Context
import android.content.Intent
import androidx.core.content.ContextCompat
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationResult
import com.ludisy.app.plugin.ForegroundService
import com.ludisy.app.plugin.data.model.BikingObj
import com.ludisy.app.plugin.data.model.RollerSkatingObj
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.schedulers.Schedulers

class RollerSkatingForegroundService : ForegroundService() {
    companion object {
        fun startService(context: Context, message: String) {
            val startIntent = Intent(context, RollerSkatingForegroundService::class.java)
            startIntent.putExtra("inputExtra", message)
            ContextCompat.startForegroundService(context, startIntent)
        }

        fun stopService(context: Context) {
            val stopIntent = Intent(context, RollerSkatingForegroundService::class.java)
            context.stopService(stopIntent)
        }
    }

    override fun getNotificationName(): String {
        return "Ludisy Roller Skating"
    }

    override var locationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult) {
            if (locationResult.lastLocation != null) {
                locationHelper.stopLocationUpdates(this)
                println(locationResult.toString())
                var rollerSkatingObj = RollerSkatingObj(
                        null,
                        locationResult.lastLocation.longitude,
                        locationResult.lastLocation.latitude,
                        locationResult.lastLocation.speed,
                        System.currentTimeMillis()
                )
                disposable = saveData(rollerSkatingObj).subscribeOn(Schedulers.io())
                        .subscribe()
            }
        }

        fun saveData(rollerSkatingObj: RollerSkatingObj): Single<Unit> {
            return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
                try {
                    var id = appDatabase?.rollerSkatingDao()?.insert(rollerSkatingObj)
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