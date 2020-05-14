package com.ludisy.app.plugin

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.location.LocationManager
import android.os.Build
import android.os.Handler
import android.os.IBinder
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat
import androidx.room.Room
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationResult
import com.ludisy.app.MainActivity
import com.ludisy.app.R
import com.ludisy.app.plugin.data.AppDatabase
import com.ludisy.app.plugin.data.model.BikingObj
import io.reactivex.Single
import io.reactivex.SingleEmitter
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import java.lang.NullPointerException

class ForegroundService : Service() {
    private val CHANNEL_ID = "ForegroundService Kotlin"

    companion object {
        fun startService(context: Context, message: String) {
            val startIntent = Intent(context, ForegroundService::class.java)
            startIntent.putExtra("inputExtra", message)
            ContextCompat.startForegroundService(context, startIntent)
        }

        fun stopService(context: Context) {
            val stopIntent = Intent(context, ForegroundService::class.java)
            context.stopService(stopIntent)
        }
    }

    var mHandler: Handler = Handler()

    val locationHelper = LocationHelper();

    val NOTIFY_INTERVAL = 10 * 1000 // 10 seconds
            .toLong()

    private var appDatabase: AppDatabase? = null

    private lateinit var disposable: Disposable
    // timer handling
    override fun onCreate() { // cancel if already existed
        appDatabase = Room.databaseBuilder(
                applicationContext,
                AppDatabase::class.java, "workout_database"
        ).build()

    }

    override fun onDestroy() {
        super.onDestroy()
        mHandler.removeCallbacks(runnableCode);
        if (!disposable.isDisposed) {
            disposable.dispose()
        }
    }

    private val runnableCode: Runnable = object : Runnable {
        override fun run() { // Do something here on the main thread
            getLocation()
            mHandler.postDelayed(this, NOTIFY_INTERVAL)
        }
    }

    @RequiresApi(Build.VERSION_CODES.P)
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        //do heavy work on a background thread
        val input = intent?.getStringExtra("inputExtra")
        createNotificationChannel()
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
                this,
                0, notificationIntent, 0
        )
        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("Foreground Service Kotlin Example")
                .setContentText(input)
                .setSmallIcon(R.drawable.appstore)
                .setContentIntent(pendingIntent)
                .build()
        startForeground(1, notification)
        mHandler.post(runnableCode)
        //stopSelf();
        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val serviceChannel = NotificationChannel(
                    CHANNEL_ID, "Foreground Service Channel",
                    NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager!!.createNotificationChannel(serviceChannel)
        }
    }

    private fun getLocation() {
        val locationManager =
                this.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        if (!locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            println("no gps")
        } else {
            locationHelper.startLocationUpdates(
                    this,
                    locationCallback
            )
        }
    }

    val locationCallback = object : LocationCallback() {
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