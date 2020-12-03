<?php
class Mutex
{
    var $writeablePath = '';
    var $lockName = '';
    var $fileHandle = null;
    public function __construct($lockName, $writeablePath = null)
    {
        $this->lockName = $lockName . ".lock";
        if ($writeablePath == null) {
            $this->writeablePath = __DIR__ . DIRECTORY_SEPARATOR . 'lock';
        }
        if(!is_dir($this->writeablePath)){
            mkdir($this->writeablePath);
        }
        file_fix_write($this->writeablePath);
        return $this;
    }
    public function ControlLock($time = 0)
    {
        if ($this->isLocked() || $this->getLastModified() < $time) {
            return false;
        }
        return $this->getLock();
    }
    public function getLastModified()
    {
        return time() - filemtime($this->getLockFilePath());
    }
    public function getLock()
    {
        return flock($this->getFileHandle(), LOCK_EX);
    }
    public function getFileHandle()
    {
        if(file_exists($this->getLockFilePath())){
            file_fix_write($this->getLockFilePath());
        }
        if ($this->fileHandle == null) {
            $this->fileHandle = fopen($this->getLockFilePath(), 'c');
        }
        return $this->fileHandle;
    }
    public function releaseLock()
    {
        $success = flock($this->getFileHandle(), LOCK_UN);
        fclose($this->getFileHandle());
        touch($this->getLockFilePath());
        return $success;
    }
    public function getLockFilePath()
    {
        return $this->writeablePath . DIRECTORY_SEPARATOR . $this->lockName;
    }
    public function isLocked()
    {
        $fileHandle = fopen($this->getLockFilePath(), 'c');
        $canLock    = flock($fileHandle, LOCK_EX);
        if ($canLock) {
            flock($fileHandle, LOCK_UN);
            fclose($fileHandle);
            return false;
        } else {
            fclose($fileHandle);
            return true;
        }
    }
    public function findWriteablePath()
    {
        $fileName   = tempnam("/tmp", "LOCK");
        $path       = dirname($fileName);
        $fileHandle = fopen($fileName, "c");
        if (flock($fileHandle, LOCK_EX)) {
            flock($fileHandle, LOCK_UN);
            fclose($fileHandle);
            $this->writeablePath = $path;
        } else {
            //throw new Exception("Cannot establish lock on temporary file.");
            exit("LOCK FAILED");
        }
    }
}