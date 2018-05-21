module GhciLess
  where
import System.Process
import System.Posix.IO
import System.Posix.Types
import Data.IORef
import System.IO.Unsafe

{-# NOINLINE pid_ref #-}
pid_ref :: IORef (ProcessHandle, Fd)
pid_ref = unsafePerformIO $ newIORef undefined

reloadInLess :: String -> IO String
reloadInLess mod_ = do
  stdout_copy <- dup stdOutput

  (Just pipe_handle, Nothing, Nothing, pid)
    <- createProcess (proc "less" []) { std_in = CreatePipe }

  closeFd stdOutput

  pipe_fd <- handleToFd pipe_handle
  dupTo pipe_fd stdOutput
  closeFd pipe_fd
  writeIORef pid_ref (pid, stdout_copy)

  return $ unlines
    [ ":reload " ++ mod_
      -- , "finish"
    ]

  -- (pid, stdout_copy) <- readIORef pid_ref
  -- waitForProcess pid
  -- dupTo stdout_copy stdOutput
  -- closeFd stdout_copy
  -- return ""

finish :: IO ()
finish = do
  closeFd stdOutput
  (pid, stdout_copy) <- readIORef pid_ref
  waitForProcess pid
  dupTo stdout_copy stdOutput
  closeFd stdout_copy
