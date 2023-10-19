package com.dipotter.video_player_native.services
import java.io.File

class FileManager {
    fun getFileExtensionFromUrl(url: String): String? {
        try {
            val uri = java.net.URI(url)
            val path = uri.path
            if (path != null) {
                val fileName = File(path).name
                val dotIndex = fileName.lastIndexOf(".")
                if (dotIndex >= 0 && dotIndex < fileName.length - 1) {
                    return fileName.substring(dotIndex + 1)
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return null
    }
}