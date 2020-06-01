package com.ludisy.app.plugin.data.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.google.gson.annotations.SerializedName

@Entity
data class RollerSkatingObj(
        @PrimaryKey(autoGenerate = true) val uid: Int?,
        @SerializedName("longitude") @ColumnInfo(name = "longitude") val longitude: Double?,
        @SerializedName("latitude") @ColumnInfo(name = "latitude") val latitude: Double?,
        @SerializedName("speed") @ColumnInfo(name = "speed") val speed: Float?,
        @SerializedName("whenSec") @ColumnInfo(name = "whenSec") val whenSec: Long?
)