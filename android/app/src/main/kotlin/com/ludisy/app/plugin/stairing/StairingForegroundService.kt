package com.ludisy.app.plugin.stairing

import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import androidx.core.content.ContextCompat
import com.ludisy.app.plugin.ForegroundService
import com.ludisy.app.plugin.data.model.StairingObj
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.schedulers.Schedulers

class StairingForegroundService : ForegroundService(), SensorEventListener {
    var sensorManager: SensorManager? = null

    var steps = 0

    private var offset = 0

    var notInitialized = true

    override fun getNotificationName(): String {
        return "Ludisy Stair climbing"
    }

    companion object {
        fun startService(context: Context, message: String) {
            val startIntent = Intent(context, StairingForegroundService::class.java)
            startIntent.putExtra("inputExtra", message)
            ContextCompat.startForegroundService(context, startIntent)
        }

        fun stopService(context: Context) {
            val stopIntent = Intent(context, StairingForegroundService::class.java)
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

    override fun onDestroy() {
        super.onDestroy()
        sensorManager?.unregisterListener(this)
    }

    override fun onAccuracyChanged(p0: Sensor?, p1: Int) {
    }

    override fun onSensorChanged(event: SensorEvent) {
        if (notInitialized) {
            offset = event.values[0].toInt()
            notInitialized = false
        }
        steps = event.values[0].toInt() - offset
    }

    override val runnableCode: Runnable = object : Runnable {
        override fun run() { // Do something here on the main thread
            val stairingObj = StairingObj(null,
                    steps, System.currentTimeMillis()
            )
            disposable = saveData(stairingObj).subscribeOn(Schedulers.io())
                    .subscribe()
            mHandler.postDelayed(this, NOTIFY_INTERVAL)
        }
    }

    fun saveData(stairingObj: StairingObj): Single<Unit> {
        return Single.create<Unit> { emitter: SingleEmitter<Unit> ->
            try {
                var id = appDatabase?.stairingDao()?.insert(stairingObj)
                if (id != null) {
                    emitter.onSuccess(Unit);
                } else {
                    emitter.onError(NullPointerException())
                }
            } catch (e: Exception) {
                emitter.onError(e)
            }
        }
    }

}