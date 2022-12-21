package com.hwfs.sc.cmn.util;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.web.multipart.MultipartFile;

import com.hwfs.cmn.util.DateUtil;
import com.hwfs.cmn.util.StringUtil;
import com.hwfs.sc.cmn.dto.AttachFileDTO;

 /**
 * 프로젝트에서 공통으로 사용하는 File Utility
 * @ClassName FileUtil.java
 * @Description FileUtil Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 8.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 8.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FileUtil extends com.hwfs.cmn.util.FileUtil {
    /**
     * attchFile을 저장소에 저장하고 파일 정보를 List<AttachFileVO>형태로 반환한다.
     *
     * @param uploadPath
     * @param files Map형태의 첨부파일 정보
     * @param partPath
     * @return List<FileInfoVO>
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
    public static List<AttachFileDTO> attchFileUpload(String uploadPath, Map files, String partPath) throws Exception {
        String strDateNow = DateUtil.getYyyymmddhhmmss();
        String uploadPathTmp = StringUtil.replaceRelativePath(uploadPath);
        if (partPath != null && !partPath.equals("")) uploadPathTmp += "/" + partPath;
        File saveFolder = new File(uploadPathTmp);

        // 디렉토리 생성
        if (!saveFolder.exists() || saveFolder.isFile()) {
            saveFolder.mkdirs();
        }

        Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        MultipartFile file;
        String filePath;

        List fileInfoList = new ArrayList();
        AttachFileDTO fileInfoVO = null;
        ArrayList fileName = new ArrayList();
        int sameVal = 0;

        while (itr.hasNext()) {
            Entry<String, MultipartFile> entry = itr.next();

            file = entry.getValue();
            if (!"".equals(file.getOriginalFilename())) {
                String orgFileName = file.getOriginalFilename();

                if(fileName.size() > 0) {

                    String flag = "N";

                    for(int i=0;i<fileName.size();i++) {
                        if(file.getOriginalFilename().equals(fileName.get(i))) {
                            flag = "Y";
                        }
                    }

                    if(flag.equals("Y")) {
                        sameVal++;
                        orgFileName = file.getOriginalFilename() + "(" + sameVal + ")";
                    }
                }

                fileName.add(file.getOriginalFilename());

                filePath = uploadPathTmp + "/" + strDateNow + "_" + orgFileName;
                file.transferTo(new File(StringUtil.replaceURLFormat(filePath)));

                fileInfoVO = new AttachFileDTO();

                fileInfoVO.setFullPath(filePath);
                fileInfoVO.setRelPath("");
                fileInfoVO.setOrgnlFileNm(file.getOriginalFilename());
                fileInfoVO.setSaveFileNm(strDateNow + "_" + orgFileName);
                fileInfoVO.setFileSize(file.getSize());
                //fileInfoVO.setFileType(file.getContentType()); //확장자로 변경
                fileInfoVO.setFileExt(getExt(orgFileName));
                fileInfoVO.setFileDesc(fileInfoVO.getFileDesc());
                
                fileInfoList.add(fileInfoVO);
            }
        }

        return fileInfoList;
    }

}
