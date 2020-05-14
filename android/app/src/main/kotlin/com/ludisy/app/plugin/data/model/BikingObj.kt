package com.ludisy.app.plugin.data.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class BikingObj(
        @PrimaryKey(autoGenerate = true) val uid: Int?,
        @ColumnInfo(name = "longitude") val longitude: Double?,
        @ColumnInfo(name = "latitude") val latitude: Double?,
        @ColumnInfo(name = "altitude") val altitude: Double?,
        @ColumnInfo(name = "speed") val speed: Float?,
        @ColumnInfo(name = "whenSec") val whenSec: Long?
)