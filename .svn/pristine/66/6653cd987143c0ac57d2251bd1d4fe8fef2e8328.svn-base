package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.activation.MimetypesFileTypeMap;
import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dao.ResizeImageDAO;
import com.hwfs.sc.cmn.util.Scalr;
import com.hwfs.sc.cmn.util.Scalr.Mode;

/**
 * 첨부파일 공간의 경량화를 위한 이미지 resize 서비스
 * @ClassName ResizeImageFileServiceImpl.java
 * @Description ResizeImageFileServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.08.10.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : kihoon
 * @since 2017.08.10.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/resizeImageFileService")
public class ResizeImageFileServiceImpl extends DefaultServiceImpl implements ResizeImageFileService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	@Resource(name = "/sc/cmn/resizeImageDAO")
	private ResizeImageDAO resizeImageDAO;
	
	private static int maxFileSize = 1048576;
	
	private static Date frDate = null;
	private static Date toDate = null;
	/**
	 * select 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.ResizeImageFileService#select()
	*/
	@Override
	public RecordSet select() throws Exception {
		return resizeImageDAO.select();
	}	
	
	@SuppressWarnings("unchecked")
	@Override
	public int resizeImageFile() throws Exception {
		
		int excuteCnt = 0;
		int progressCnt = 0;
		try {
        	
        	RecordSet rs = select();
        	if ( rs.getRowCount() == 0  ) {
        		throw new BizException("리사이즈할 대상 저장소 정보가 존재하지 않습니다.");
        	} else {
        		
        		String sourceFile = rs.get(0).getString("code");
        		int targetSize = rs.get(0).getInt("set1");
        		int maxImgSize = rs.get(0).getInt("set2");
        		DateFormat formatter = new SimpleDateFormat("yyyyMMdd");
        		frDate = (Date)formatter.parse(rs.get(0).getString("set3"));
        		toDate = (Date)formatter.parse(rs.get(0).getString("set4"));
        		
        		if ( maxImgSize != 0 ) {
        			maxFileSize = maxImgSize;
        		}
        		logger.info("\n#################################################################################################");
        		logger.info("\nfrDate: {}	\ntoDate: {} \nsourceFile : {} \ntargetSize : {} \nmaxImgSize : {} ", frDate, toDate, sourceFile, targetSize, maxFileSize);
        		logger.info("#################################################################################################");        		
        		String mode = super.propertiesService.getString("run.mode");
        		
        		if ( "localhost".equals(mode) ) {
        			sourceFile =  propertiesService.getString("global.fileupload.path");
        		}
        		
        		logger.info("sourceFile : {}", sourceFile);
        		FileFilter fileFilter = new FileFilter() {
        			public boolean accept(File file) {
        				Date d = new Date(file.lastModified());
        				//SimpleDateFormat dt = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
        				//logger.info("fileInfo {} / {}", file.getName(), dt.format(d));
        				return ( frDate.compareTo(d) * d.compareTo(toDate) >= 0 ) && (file.length() > maxFileSize) ;
        				
        			}
        		};
        		
        		File[] images = new File(sourceFile).listFiles(fileFilter);
        		
        		/**
        		Arrays.sort( images, new Comparator() {
        			public int compare(Object o1, Object o2) {
        				if (((File)o1).lastModified() > ((File)o2).lastModified()) {
        		            return -1;
        		        } else if (((File)o1).lastModified() < ((File)o2).lastModified()) {
        		            return +1;
        		        } else {
        		            return 0;
        		        }
        			}
        		});
        		**/
        		
        		int listCnt = images.length;
            	
        		for (File f : images) {
                    
                    if (f.isDirectory()) {
                    	logger.info("\t Skipping, file is a directory...");
                        continue;
                    } else {
                    	excuteCnt += process(f, targetSize, maxFileSize);
                    }
                    progressCnt++;
                    
                    logger.info("[ {}/{} ]", LimsUtil.getCommaNumber(progressCnt, "###,###,###,##0"), LimsUtil.getCommaNumber(listCnt, "###,###,###,##0"));
                }
        		
        		logger.info("####################### excute count {} #######################", excuteCnt);
        	}
        }catch (Exception e){
            logger.error("************resizeImageFile Exception : {} ************", e);
        }
		
		return excuteCnt;
    }
	
	private int process(File file, int size, int maxSize) throws IOException {
		//logger.info("[Info] File {}", file);
		
		int resultCnt = 0;
		//if ( file.length() > maxSize ) {
			String mimeType = new MimetypesFileTypeMap().getContentType(file);
			String type = mimeType.split("/")[0];
			String fileExt = file.getName().substring(file.getName().lastIndexOf('.') + 1);
			
			logger.info("[Check] fileName : {}  mimeType : {}	fileSize : {}", file.getName(), mimeType, file.length());
			
			// 이미지파일
			if ( type.equals("image") || fileExt.equalsIgnoreCase("png") || fileExt.equalsIgnoreCase("bmp") ) {
				
				try {
					
					BufferedImage image = ImageIO.read(file);
					
					if ( fileExt.equalsIgnoreCase("bmp") ) {
						image = Scalr.resize(image, Mode.BEST_FIT_BOTH, size);
					} else {
						image = Scalr.resize(image, Mode.AUTOMATIC, size);
					}
					
					saveResizeImage(file, image);
			        resultCnt++;
				} catch (Exception e){
					 logger.error("************resizeImageFile-process() Exception : {}", e.getMessage().toString());
				}
			}
		//}	
		return resultCnt;
    }
	
	private void saveResizeImage(File originalFile, BufferedImage thumbnail)
            throws IOException {
		String filename =  originalFile.getPath();
        
        String fileExt = filename.substring(filename.lastIndexOf('.') + 1);
        logger.info("[Process] FileName = {}", filename);
        ImageIO.write(thumbnail, fileExt, new File(filename));
    }

	
}