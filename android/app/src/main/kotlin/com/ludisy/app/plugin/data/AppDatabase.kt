package com.ludisy.app.plugin.data

import androidx.room.Database
import androidx.room.RoomDatabase
import com.ludisy.app.plugin.data.dao.BikingDao
import com.ludisy.app.plugin.data.dao.RollerSkatingDao
import com.ludisy.app.plugin.data.dao.RunningDao
import com.ludisy.app.plugin.data.dao.StairingDao
import com.ludisy.app.plugin.data.model.BikingObj
import com.ludisy.app.plugin.data.model.RunningObj
import com.ludisy.app.plugin.data.model.RollerSkatingObj
import com.ludisy.app.plugin.data.model.StairingObj

@Database(entities = [BikingObj::class, RollerSkatingObj::class, RunningObj::class, StairingObj::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun bikingDao(): BikingDao
    abstract fun rollerSkatingDao(): RollerSkatingDao
    abstract fun runningDao(): RunningDao
    abstract fun stairingDao(): StairingDao
}