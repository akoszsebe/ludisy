package com.ludisy.app.plugin.data.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.ludisy.app.plugin.data.model.BikingObj


@Dao
interface BikingDao {
    @Query("SELECT * FROM BikingObj")
    fun getAll(): List<BikingObj>

    @Insert
    fun insertAll(vararg bikingObjs: BikingObj)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(bikingObj: BikingObj?): Long

    @Query("DELETE FROM BikingObj")
    fun deleteAll()
}