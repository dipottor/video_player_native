package com.dipotter.video_player_native

import android.annotation.SuppressLint
import android.os.Build
import android.os.Bundle
import android.webkit.MimeTypeMap.getFileExtensionFromUrl
import android.widget.Switch
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import com.dipotter.video_player_native.databinding.ActivityPlayerBinding

/**
 * A fullscreen activity to play audio or video streams.
 */
enum class MIMEType {
    DASH, MP3, MP4, M3U8, NONE
}

class PlayerActivity : AppCompatActivity() {

    private val viewBinding by lazy(LazyThreadSafetyMode.NONE) {
        ActivityPlayerBinding.inflate(layoutInflater)
    }

    private var player: Player? = null

    private var playWhenReady = true
    private var mediaItemIndex = 0
    private var playbackPosition = 0L
    private var contentUrl =
        "https://stage-upload-test.s3.ap-south-1.amazonaws.com/1100/master.m3u8"
            ;

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(viewBinding.root)
        // Retrieve the message from the Intent
        //   contentUrl = intent.getStringExtra("contentUrl").toString()

    }

    public override fun onStart() {
        super.onStart()
        if (Build.VERSION.SDK_INT > 23) {
            initializePlayer()
        }
    }

    public override fun onResume() {
        super.onResume()
        hideSystemUi()
        if (Build.VERSION.SDK_INT <= 23 || player == null) {
            initializePlayer()
        }
    }

    public override fun onPause() {
        super.onPause()
        if (Build.VERSION.SDK_INT <= 23) {
            releasePlayer()
        }
    }

    public override fun onStop() {
        super.onStop()
        if (Build.VERSION.SDK_INT > 23) {
            releasePlayer()
        }
    }

    private fun initializePlayer() {
        // ExoPlayer implements the Player interface
        player = ExoPlayer.Builder(this)
            .build()
            .also { exoPlayer ->
                viewBinding.videoView.player = exoPlayer
                val mp4Url =
                    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                val mp3Url =
                    "https://storage.googleapis.com/exoplayer-test-media-0/Jazz_In_Paris.mp3"

                val media = createMedia(contentUrl)
                if (media != null) {
                    exoPlayer.setMediaItems(
                        listOf(media) as MutableList<MediaItem>,
                        mediaItemIndex,
                        playbackPosition
                    )
                    exoPlayer.playWhenReady = playWhenReady
                    exoPlayer.prepare()
                } else {
                    print("Cant play content, MIME type is missing")
                }
            }
    }


    private fun createMedia(contentUrl: String): MediaItem? {
        var currentMedia: MediaItem? = null;
        val fileExtension = getFileExtensionFromUrl(contentUrl)
        if (fileExtension != null) {
            when (fileExtension) {
                MIMEType.DASH.toString().lowercase() -> {
                    currentMedia = MediaItem.Builder()
                        .setUri(contentUrl)
                        .setMimeType(MimeTypes.APPLICATION_MPD)
                        .build()
                }
                MIMEType.M3U8.toString().lowercase() -> {
                    currentMedia = MediaItem.Builder()
                        .setUri(contentUrl)
                        .setMimeType(MimeTypes.APPLICATION_M3U8)
                        .build()
                }
                MIMEType.MP4.toString().lowercase() -> {
                    currentMedia = MediaItem.fromUri(contentUrl);
                }
                MIMEType.MP3.toString().lowercase() -> {
                    currentMedia = MediaItem.fromUri(contentUrl);
                }
                else -> MIMEType.MP4
            }
        }
        return currentMedia
    }

    private fun releasePlayer() {
        player?.let { player ->
            playbackPosition = player.currentPosition
            mediaItemIndex = player.currentMediaItemIndex
            playWhenReady = player.playWhenReady
            player.release()
        }
        player = null
    }

    @SuppressLint("InlinedApi")
    private fun hideSystemUi() {
        WindowCompat.setDecorFitsSystemWindows(window, false)
        WindowInsetsControllerCompat(window, viewBinding.videoView).let { controller ->
            controller.hide(WindowInsetsCompat.Type.systemBars())
            controller.systemBarsBehavior =
                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        }
    }
}