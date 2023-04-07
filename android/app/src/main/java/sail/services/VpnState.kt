package sail.services

import kotlinx.coroutines.Job

object VpnState {
    enum class State {
        /**
         * Idle state is only used by UI and will never be returned by BaseService.
         */
        Idle,
        Connecting,
        Connected,
        Stopping,
        Stopped,
    }

    const val CONFIG_FILE = "leaf.conf"
    const val LEAF_LOG_FILE = "leaf.log"

    class Data internal constructor() {
        var state = State.Stopped
        fun changeState(s: State, msg: String? = null) {
            if (state == s && msg == null) return
            state = s
        }
    }
}
