package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lcm.dao.UserMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 담당자 관리 ServiceImple Class
 *
 * @ClassName UserMgmtServiceImple.java
 * @Description UserMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 9.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 9.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/userMgmtService")
public class UserMgmtServiceImpl extends DefaultServiceImpl implements UserMgmtService {

    @Resource(name = "/ls/lcm/userMgmtDAO")
    private UserMgmtDAO userMgmtDAO;

    /**
     * 담당자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.UserMgmtService#selectUserMgmtList(java.util.Map)
    */
    @Override
    public RecordSet selectUserMgmtList(Map<String, Object> parameter) throws Exception {
        return userMgmtDAO.selectUserMgmtList(parameter);
    }

    /**
     * 권한별 담당자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.UserMgmtService#selectUserList(java.util.Map)
    */
    @Override
    public RecordSet selectUserList(Map<String, Object> parameter) throws Exception {
        return userMgmtDAO.selectUserList(parameter);
    }

    /**
     * 담당자 이력을 저장한다.
     *
     * @param userLogList
     * @param rparLogList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.UserMgmtService#saveUserList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveUserList(String realPath, DataSetMap userLogList) throws Exception {
        int userProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        Map<String, Object> retVal = new HashMap<String, Object>();
        byte[] blob;
        String strSabun = "";
        String strAppendFilenm = "";
        String fileExt = "";
        String strSignFile = "";
        //int userCnt = 0;

        for (int i = 0; i < userLogList.size(); i++) {
            parameter = userLogList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            // 성적서 발급을 위해 서명 blob을 파일로 저장 한다.
            if (rowType != DataSet.ROW_TYPE_DELETED) {
                strSignFile = LimsUtil.checkNull(parameter.get("signFile"));
                if (!"".equals(strSignFile)) {
                    blob = (byte[]) parameter.get("signFile");
                    strSabun = LimsUtil.checkNull(parameter.get("sabun"));
                    strAppendFilenm = LimsUtil.checkNull(parameter.get("appendFilenm"));
                    fileExt = LimsUtil.getFileExt(strAppendFilenm);
                    //LimsUtil.saveBlobToFile(propertiesService.getString("ls.img.upload.path") + File.separator + strSabun + "." + fileExt, blob);
                    LimsUtil.saveBlobToFile(realPath + strSabun + "." + fileExt, blob);
                    if (!"".equals(fileExt)) {
                        parameter.put("svrFilenm", strSabun + "." + fileExt);	// 서버에 저장된 파일명
                    }
                }
            }

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                //userCnt = userMgmtDAO.selectUser(parameter);
                //if (userCnt == 0) {
                    userProcCnt += userMgmtDAO.insertUserList(parameter);
                //} else {
                //    throw processException("ls.dataChkDup"); // 중복 데이터 오류
                //}
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                userProcCnt += userMgmtDAO.updateUserList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {
                userProcCnt += userMgmtDAO.deleteUserList(parameter);
            }
        }

        retVal.put("procCnt", userProcCnt);

        return retVal;
    }

    /**
     * 식품연구소 사원을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.UserMgmtService#selectHrUserList(java.util.Map)
    */
    @Override
    public RecordSet selectHrUserList(Map<String, Object> parameter) throws Exception {
        return userMgmtDAO.selectHrUserList(parameter);
    }

}
