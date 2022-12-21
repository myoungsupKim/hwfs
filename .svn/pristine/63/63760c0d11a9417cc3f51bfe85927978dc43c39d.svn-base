package com.hwfs.am.ams.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.am.ams.dao.EquipmentRegistDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 전산장비 등록 관리 ServiceImple Class
 *
 * @ClassName EquipmentRegistServiceImple.java
 * @Description EquipmentRegistServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.12.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/am/ams/equipmentRegistService")
public class EquipmentRegistServiceImpl extends DefaultServiceImpl implements EquipmentRegistService {

    @Resource(name = "/am/ams/equipmentRegistDAO")
    private EquipmentRegistDAO equipmentRegistDAO;
 
    /**
     * 전산장비 관리자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#selectAdminList(java.util.Map)
    */
    @Override
    public RecordSet selectAdminList(Map<String, Object> mapParam) throws Exception {

    	return equipmentRegistDAO.selectAdminList(mapParam);
    }

    @Override
    public RecordSet selectBarprtList(Map<String, Object> mapParam) throws Exception {

    	return equipmentRegistDAO.selectBarprtList(mapParam);
    }
    
    /**
     * 전산장비 등록정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return equipmentRegistDAO.selectList(mapParam);
    }

    /**
     * 전산장비 등록정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#saveList(java.util.Map)
    */
	@SuppressWarnings("unchecked")
	public int saveList(String realPath, DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
        String strImgFile = "";
        byte[] blob;
        String strEqNo = "";
        String strAppendFilenm = "";
        String fileExt = "";

        for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//장비관리번호 처리
			strEqNo = LimsUtil.checkNull(rowData.get("eqNo"));
            if ("".equals(strEqNo)) {
				strEqNo = equipmentRegistDAO.selectEqno(rowData);
                rowData.put("eqNo", strEqNo);
            }

			// 이미지 blob를 파일로 저장 한다.
            if (rowType != DataSet.ROW_TYPE_DELETED) {
            	strImgFile = LimsUtil.checkNull(rowData.get("imgFile"));
                if (!"".equals(strImgFile)) {
                    blob = (byte[]) rowData.get("imgFile");
                    strAppendFilenm = LimsUtil.checkNull(rowData.get("appendFilenm"));
                    // 이미지파일 유효 확장자 체크
                    if(!"".equals(strAppendFilenm) && !"undefined".equals(strAppendFilenm)) {
                        if(!"bmp".equals(fileExt.toLowerCase()) && !"jpg".equals(fileExt.toLowerCase()) && !"jpeg".equals(fileExt.toLowerCase()) && !"gif".equals(fileExt.toLowerCase()) && !"png".equals(fileExt.toLowerCase())) {
                        	throw processException("am.ams.fail.imgUpload"); //이미지 확장자가 올바르지 않습니다.
                        }                    	
                    }
                    fileExt = LimsUtil.getFileExt(strAppendFilenm);
                    LimsUtil.saveBlobToFile(realPath + strEqNo + "." + fileExt, blob);
                    if (!"".equals(fileExt)) {
                    	rowData.put("serverFilenm", strEqNo + "." + fileExt);	// 서버에 저장된 파일명
                    }
                }
            }
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += equipmentRegistDAO.insert(rowData);
				
				//이력생성(입력)
				Map<String, Object> inParam = new HashMap<String, Object>();
				Map<String, Object> retVal = new HashMap<String, Object>();				
				String callProcName = "AMS_EQ_HIST_PROCESS_PRO";

				inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("eqNo")));
				inParam.put("P_CHG_GUBUN", "입력");
				inParam.put("P_CHG_TEXT", "전산장비 신규 등록");
				inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));
				
				retVal = equipmentRegistDAO.callAmsProcedure(inParam, callProcName);

				// 프로시저 실패시 롤백
				if("FALSE".equals(retVal.get("O_RTN").toString())){
					throw new BizException(retVal.get("O_RTNMSG").toString());
				}
				
				//신규입력(재고상태) 귀속업장,귀속사용자 등록 데이터 지급상태로 Update
				updRowCnt += equipmentRegistDAO.updateA(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += equipmentRegistDAO.update(rowData);
				
				//이력생성(수정)
				//AMS_EQ_MST Trigger(AMS_EQ_MST_AI)
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += equipmentRegistDAO.delete(rowData);

				//이력생성(삭제)
				Map<String, Object> inParam = new HashMap<String, Object>();
				Map<String, Object> retVal = new HashMap<String, Object>();				
				String callProcName = "AMS_EQ_HIST_PROCESS_PRO";

				inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("eqNo")));
				inParam.put("P_CHG_GUBUN", "삭제");
				inParam.put("P_CHG_TEXT", "전산장비 마스터 삭제");
				inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));
				
				retVal = equipmentRegistDAO.callAmsProcedure(inParam, callProcName);

				// 프로시저 실패시 롤백
				if("FALSE".equals(retVal.get("O_RTN").toString())){
					throw new BizException(retVal.get("O_RTNMSG").toString());
				}				
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
    
    /**
     * 전산장비 마스터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#selectEqList(java.util.Map)
    */
    @Override
    public RecordSet selectEqList(Map<String, Object> mapParam) throws Exception {
        return equipmentRegistDAO.selectEqList(mapParam);
    }

    /**
     * 전산장비 히스토리 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#selectHist(java.util.Map)
    */
    @Override
    public RecordSet selectHist(Map<String, Object> mapParam) throws Exception {
        return equipmentRegistDAO.selectHist(mapParam);
    }

    /**
     * 전산장비 AS정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#selectAsList(java.util.Map)
    */
    @Override
    public RecordSet selectAsList(Map<String, Object> mapParam) throws Exception {
        return equipmentRegistDAO.selectAsList(mapParam);
    }

    /**
     * 전산장비 AS 특이사항 정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#saveAsList(java.util.Map)
    */
	@SuppressWarnings("unchecked")
	public int saveAsList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += equipmentRegistDAO.insertAs(rowData);
				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += equipmentRegistDAO.updateAs(rowData);

			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += equipmentRegistDAO.deleteAs(rowData);
				
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}

    /**
     * 전산장비 출력정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#savePrtList(java.util.Map)
    */
	@SuppressWarnings("unchecked")
	public int savePrtList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		String strChk = "";
		String strStatCd = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {

				if(rowData.get("chk") != null)	strChk	= rowData.get("chk").toString();
				if(rowData.get("statCd") != null)	strStatCd	= rowData.get("statCd").toString();
				//선택
				if("1".equals(strChk)) {
					//재고,지급
					if("I".equals(strStatCd) || "P".equals(strStatCd)) {
						updRowCnt += equipmentRegistDAO.updatePrt(rowData);
					}
				}
			}
		}
				
		return updRowCnt;
	}

    /**
     * 상세 코드 일괄 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRegistService#selectCodeDtlBatchList(java.util.Map)
    */
    @Override
    public RecordSet selectCodeDtlBatchList(Map<String, Object> parameter) throws Exception {
        parameter.put("groupCodeList", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("groupCodeList")), ","));
        return equipmentRegistDAO.selectCodeDtlBatchList(parameter);
    }

}