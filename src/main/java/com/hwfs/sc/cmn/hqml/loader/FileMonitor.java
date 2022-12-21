package com.hwfs.sc.cmn.hqml.loader;

import java.io.*;
import java.util.*;

 /**
 * FileMonitor에 대한 설명 작성
 * @ClassName FileMonitor.java
 * @Description FileMonitor Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 8.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 1. 8.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FileMonitor
{
    private static FileMonitor fileMonitor = null;
    Timer timer = null;
    @SuppressWarnings("rawtypes")
	//Iterator monitorTasks;
    Map monitorTasks; //Hashtable monitorTasks;

    public class FileMonitorTask extends TimerTask
    {

        String fileName;
        File monitorFile = null;
        private long lastModifiedTime = 0L;
        FileChangeListener fileChangeListener = null;

        public void run()
        {
            long modifiedTime = monitorFile.lastModified();
            if(lastModifiedTime != modifiedTime)
            {
                if(lastModifiedTime != 0L)
                    fireFileChangeEvent(fileChangeListener, fileName);
                lastModifiedTime = modifiedTime;
            }
        }

        public FileMonitorTask(FileChangeListener fileChangeListener, String fileName)
            throws FileNotFoundException
        {
            this.fileName = null;
            monitorFile = null;
            lastModifiedTime = 0L;
            this.fileChangeListener = null;
            this.fileChangeListener = fileChangeListener;
            this.fileName = fileName;
            monitorFile = new File(this.fileName);
            if(!monitorFile.exists())
                throw new FileNotFoundException("파일을 찾을수 없습니다. [파일명 : " + fileName + "]");
            else
                return;
        }
    }


    public static FileMonitor getInstance()
    {
        if(fileMonitor == null)
            fileMonitor = new FileMonitor();
        return fileMonitor;
    }

    @SuppressWarnings("rawtypes")
	public FileMonitor()
    {
        timer = null;
        monitorTasks = null;
        timer = new Timer();
        monitorTasks = new Hashtable();
    }

    @SuppressWarnings("unchecked")
	public void addFileChangeListener(FileChangeListener fileChangeListener, String fileName)
        throws FileNotFoundException
    {
        if(!monitorTasks.containsKey(fileName))
        {
            FileMonitorTask fileMonitorTask = new FileMonitorTask(fileChangeListener, fileName);
            monitorTasks.put(fileName, fileMonitorTask);
            timer.schedule(fileMonitorTask, 1000L, 3000L);
        }
    }

    public void removeFileChangeListener(FileChangeListener fileChangeListener, String fileName) throws FileNotFoundException
    {
		FileMonitorTask fileMonitorTask = (FileMonitorTask)monitorTasks.get(fileName);
		fileMonitorTask.cancel();
    }

    public void fireFileChangeEvent(FileChangeListener fileChangeListener, String fileName)
    {
        fileChangeListener.fileChanged(fileName);
    }
}