package com.ludisy.app.plugin.data.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.google.gson.annotations.SerializedName

@Entity
data class StairingObj(
        @PrimaryKey(autoGenerate = true) val uid: Int?,
        @SerializedName("count") @ColumnInfo(name = "count") val count: Int?,
        @SerializedName("whenSec") @ColumnInfo(name = "whenSec") val whenSec: Long?
)