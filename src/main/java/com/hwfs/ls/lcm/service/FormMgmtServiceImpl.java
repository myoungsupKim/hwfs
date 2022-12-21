package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lcm.dao.FormMgmtDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 양식서 관리 ServiceImple Class
 *
 * @ClassName FormMgmtServiceImple.java
 * @Description FormMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 28.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 1. 28.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/formMgmtService")
public class FormMgmtServiceImpl extends DefaultServiceImpl implements FormMgmtService {

    /** AttachFile Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    @Resource(name = "/ls/lcm/formMgmtDAO")
    private FormMgmtDAO formMgmtDAO;

    /**
     * 양식서 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.FormMgmtService#selectFormList(java.util.Map)
    */
    @Override
    public RecordSet selectFormList(Map<String, Object> parameter) throws Exception {
        return formMgmtDAO.selectFormList(parameter);
    }

    /**
     * 양식서 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.FormMgmtService#selectForm(java.util.Map)
    */
    @Override
    public Map<String, Object> selectForm(Map<String, Object> parameter) throws Exception {
        return formMgmtDAO.selectForm(parameter);
    }

    /**
     * 양식서을 저장한다.
     *
     * @param formList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.FormMgmtService#saveFormList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveFormList(DataSetMap formList, DataSetMap listFile) throws Exception {
        int formProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String formId = "";

        String strRefSeq = ""; //첨부참조일련번호
        strRefSeq = attachFileService.save(listFile, propertiesService.getString("ls.file.path"), false);

        for (int i = 0; i < formList.size(); i++) {
            parameter = formList.get(i);
            if (!"".equals(strRefSeq))
                parameter.put("refSeq", strRefSeq);

            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                formId = formMgmtDAO.selectFormId(parameter);
                parameter.put("formId", formId);
                formProcCnt += formMgmtDAO.insertFormList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                formProcCnt += formMgmtDAO.updateFormList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {
                formProcCnt += formMgmtDAO.deleteFormList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", formProcCnt);
        retVal.put("formId", formId);
        retVal.put("strRefSeq", strRefSeq);

        return retVal;
    }

    /**
     * ******************************************* 사용안함 ***********************************
     * 첨부파일 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.FormMgmtService#saveFormAttachFileDelete(java.util.Map)
    */
    public Map<String, Object> saveFormAttachFileDelete(Map<String, Object> parameter) throws Exception {
        formMgmtDAO.saveFormAttachFileDelete(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("retVal", "OK");

        return retVal;
    }

}
