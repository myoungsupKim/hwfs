package com.hwfs.ls.lum.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lum.dao.EquipMgmtDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 장비이력과 수리이력 관리 ServiceImple Class
 *
 * @ClassName EquipMgmtServiceImple.java
 * @Description EquipMgmtServiceImple Class
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
@Service("/ls/lum/equipMgmtService")
public class EquipMgmtServiceImpl extends DefaultServiceImpl implements EquipMgmtService {

    /** AttachFile Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    @Resource(name = "/ls/lum/equipMgmtDAO")
    private EquipMgmtDAO equipMgmtDAO;

    /**
     * 장비이력를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.EquipMgmtService#selectEquipLogList(java.util.Map)
    */
    @Override
    public RecordSet selectEquipLogList(Map<String, Object> parameter) throws Exception {
        return equipMgmtDAO.selectEquipLogList(parameter);
    }

    /**
     * 특정 장비이력에 맞는 수리이력를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.EquipMgmtService#selectRparLogList(java.util.Map)
    */
    @Override
    public RecordSet selectRparLogList(Map<String, Object> parameter) throws Exception {
        return equipMgmtDAO.selectRparLogList(parameter);
    }

    /**
     * 장비이력과 수리이력을 저장한다.
     *
     * @param equipLogList
     * @param rparLogList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.EquipMgmtService#saveEquipLogList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveEquipLogList(String realPath, DataSetMap equipLogList, DataSetMap rparLogList,
            DataSetMap listFile) throws Exception {
        int equipProcCnt = 0;
        int rparProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String equipNum = "";
        byte[] blob;
        String strAppendFilenm1 = "";
        String strAppendFilenm2 = "";
        String strAppendFilenm1Ext = "";
        String strAppendFilenm2Ext = "";

        String strRefSeq = ""; //첨부참조일련번호
        if ( listFile.size() > 0 ) {
            strRefSeq = attachFileService.save(listFile, propertiesService.getString("ls.file.path"), false);
        }

        for (int i = 0; i < equipLogList.size(); i++) {
            parameter = equipLogList.get(i);
            if (!"".equals(strRefSeq))
                parameter.put("refSeq", strRefSeq);

            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            // 장비사진 blob을 파일로 저장 한다.
            if (rowType != DataSet.ROW_TYPE_DELETED) {
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    equipNum = equipMgmtDAO.selectEquipNum(parameter);
                    parameter.put("equipNum", equipNum);
                } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                    equipNum = LimsUtil.checkNull(parameter.get("equipNum"));
                }

                if (!LimsUtil.checkNull(parameter.get("equipFile1")).equals("")) {
                    blob = (byte[]) parameter.get("equipFile1");
                    strAppendFilenm1 = LimsUtil.checkNull(parameter.get("appendFilenm1"));
                    strAppendFilenm1Ext = LimsUtil.getFileExt(strAppendFilenm1);
                    if (!"".equals(strAppendFilenm1)) {
                        strAppendFilenm1 = equipNum + "_appendfile1" + "." + strAppendFilenm1Ext + "_" + DateUtil.getYyyymmddhhmmss();
                        LimsUtil.saveBlobToFile(realPath + strAppendFilenm1, blob);
                        parameter.put("svrFilenm1", strAppendFilenm1); // 서버에 저장된 파일명
                    }
                }
                if (!LimsUtil.checkNull(parameter.get("equipFile2")).equals("")) {
                    blob = (byte[]) parameter.get("equipFile2");
                    strAppendFilenm2 = LimsUtil.checkNull(parameter.get("appendFilenm2"));
                    strAppendFilenm2Ext = LimsUtil.getFileExt(strAppendFilenm2);
                    if (!"".equals(strAppendFilenm2)) {
                        strAppendFilenm2 = equipNum + "_appendfile2" + "." + strAppendFilenm2Ext + "_" + DateUtil.getYyyymmddhhmmss();
                        LimsUtil.saveBlobToFile(realPath + strAppendFilenm2, blob);
                        parameter.put("svrFilenm2", strAppendFilenm2); // 서버에 저장된 파일명
                    }
                }
            }

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                //equipNum = equipMgmtDAO.selectEquipNum(parameter);
                //parameter.put("equipNum", equipNum);
                equipProcCnt += equipMgmtDAO.insertEquipLogList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                equipProcCnt += equipMgmtDAO.updateEquipLogList(parameter);
                //equipNum = LimsUtil.checkNull(parameter.get("equipNum"));
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {
                equipProcCnt += equipMgmtDAO.deleteEquipLogList(parameter);
                equipMgmtDAO.deleteRparLogListAll(parameter);
            }
        }

        // 삭제가 있으면 삭제 한다.
        for (int i = 0; i < rparLogList.size(); i++) {
            parameter = rparLogList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_DELETED) {
                rparProcCnt += equipMgmtDAO.deleteRparLogList(parameter);
            }
        }

        // 생성 또는 수정 처리 한다.
        for (int i = 0; i < rparLogList.size(); i++) {
            parameter = rparLogList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                if (!"".equals(equipNum)) {
                    parameter.put("equipNum", equipNum);
                }
                rparProcCnt += equipMgmtDAO.insertRparLogList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                rparProcCnt += equipMgmtDAO.updateRparLogList(parameter);
                equipNum = LimsUtil.checkNull(parameter.get("equipNum"));
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", equipProcCnt + rparProcCnt);
        retVal.put("equipNum", equipNum);
        retVal.put("strRefSeq", strRefSeq);

        return retVal;
    }

    /**
     * 수리이력을 저장 한다.
     *
     * @param equipNum
     * @param rparLogList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.EquipMgmtService#saveRparLogList(java.lang.String, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int saveRparLogList(String equipNum, DataSetMap rparLogList) throws Exception {
        int rparProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        // 삭제가 있으면 먼저 삭제 한다.
        for (int i = 0; i < rparLogList.size(); i++) {
            parameter = rparLogList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_DELETED) {
                parameter.put("equipNum", equipNum);
                rparProcCnt += equipMgmtDAO.deleteRparLogList(parameter);
            }
        }

        // 생성 또는 수정 처리 한다.
        for (int i = 0; i < rparLogList.size(); i++) {
            parameter = rparLogList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            parameter.put("equipNum", equipNum);
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                rparProcCnt += equipMgmtDAO.insertRparLogList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                rparProcCnt += equipMgmtDAO.updateRparLogList(parameter);
            }
        }

        return rparProcCnt;
    }

    /**
     * 첨부파일 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.EquipMgmtService#deleteEquipLogFileAppend(java.util.Map)
    */
    public Map<String, Object> deleteEquipLogFileAppend(Map<String, Object> parameter) throws Exception {
        int equipProcCnt = 0;
        equipProcCnt += equipMgmtDAO.deleteEquipLogFileAppend(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("equipProcCnt", equipProcCnt);
        retVal.put("retVal", "OK");
        return retVal;
    }

    /**
     * /**
     * 장비이력를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.EquipMgmtService#selectEquipLogList(java.util.Map)
    */
    @Override
    public Map<String, Object> selectEquipLogRefSeq(Map<String, Object> parameter) throws Exception {
        return equipMgmtDAO.selectEquipLogRefSeq(parameter);
    }

}
