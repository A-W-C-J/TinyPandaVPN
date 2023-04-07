package sail;
interface DaemonConnection {
    String getProcessName();
    void startRunTimer();
    void stopRunTimer();
}
