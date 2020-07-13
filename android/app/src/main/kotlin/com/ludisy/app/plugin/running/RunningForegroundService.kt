package com.ludisy.app.plugin.running

import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import androidx.core.content.ContextCompat
import cachet.plugins.pedometer.PedometerPlugin
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationResult
import com.ludisy.app.plugin.ForegroundService
import com.ludisy.app.plugin.data.AppDatabase
import com.ludisy.app.plugin.data.model.RunningObj
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.schedulers.Schedulers

class RunningForegroundService : ForegroundService(), SensorEventListener {
    var sensorManager: SensorManager? = null

    var steps = 0

    private var offset = 0

    var notInitialized = true

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

    override fun onCreate() {
        super.onCreate()
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val stepsSensor = sensorManager?.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)
        if (stepsSensor == null) {
            println("No Step Counter Sensor !")
        } else {
            sensorManager?.registerListener(this, stepsSensor, SensorManager.SENSOR_DELAY_UI)
        }
    }

    override fun onAccuracyChanged(p0: Sensor?, p1: Int) {
    }

    override fun onSensorChanged(event: SensorEvent) {
        if (notInitialized){
            offset = event.values[0].toInt()
            notInitialized = false
        }
        steps = event.values[0].toInt() - offset
    }

    override fun onDestroy() {
        super.onDestroy()
        sensorManager?.unregisterListener(this)
    }

    override var locationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult) {
            if (locationResult.lastLocation != null) {
                locationHelper.stopLocationUpdates(this)
                println(locationResult.toString())
                println("Steps $steps")

                var runningObj = RunningObj(
                        null,
                        locationResult.lastLocation.longitude,
                        locationResult.lastLocation.latitude,
                        locationResult.lastLocation.altitude,
                        locationResult.lastLocation.speed,
                        steps,
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