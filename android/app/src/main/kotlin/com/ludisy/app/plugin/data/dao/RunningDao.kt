package com.ludisy.app.plugin.data.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.ludisy.app.plugin.data.model.RunningObj

@Dao
interface RunningDao {
    @Query("SELECT * FROM RunningObj")
    fun getAll(): List<RunningObj>

    @Insert
    fun insertAll(vararg runningObj: RunningObj)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(runningObj: RunningObj?): Long

    @Query("DELETE FROM RunningObj")
    fun deleteAll()
}