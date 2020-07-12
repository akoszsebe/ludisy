package com.ludisy.app

import androidx.annotation.NonNull
import androidx.room.Room
import com.ludisy.app.plugin.biking.BikingMethods
import com.ludisy.app.plugin.running.RunningMethods
import com.ludisy.app.plugin.data.AppDatabase
import com.ludisy.app.plugin.rollerskating.RollerSkatingMethods
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.app.ludisy/workout"

    private val biking = BikingMethods(this)
    private val rollerSkating = RollerSkatingMethods(this)
    private val running = RunningMethods(this)


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val appDatabase = Room.databaseBuilder(
                applicationContext,
                AppDatabase::class.java, "workout_database"
        ).fallbackToDestructiveMigration().build()
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method.startsWith("biking")) {
                        biking.checkMethodCalls(appDatabase, call, result)
                    } else if (call.method.startsWith("rollerskating")) {
                        rollerSkating.checkMethodCalls(appDatabase, call, result)
                    } else if (call.method.startsWith("running")) {
                        running.checkMethodCalls(appDatabase, call, result)
                    }
                }
    }


}
