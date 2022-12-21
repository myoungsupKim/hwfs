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

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.am.ams.dao.EquipmentRequestDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 전산장비 요청 관리 ServiceImple Class
 *
 * @ClassName EquipmentRequestServiceImple.java
 * @Description EquipmentRequestServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.06.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/am/ams/equipmentRequestService")
public class EquipmentRequestServiceImpl extends DefaultServiceImpl implements EquipmentRequestService {

    @Resource(name = "/am/ams/equipmentRequestDAO")
    private EquipmentRequestDAO equipmentRequestDAO;
 
    /**
     * 전산장비 관리자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRequestService#selectAdminList(java.util.Map)
    */
    @Override
    public RecordSet selectAdminList(Map<String, Object> mapParam) throws Exception {
        return equipmentRequestDAO.selectAdminList(mapParam);
    }

    /**
     * 전산장비 요청 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRequestService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return equipmentRequestDAO.selectList(mapParam);
    }

    /**
     * 전산장비 요청 정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.am.ams.service.EquipmentRequestService#saveList(java.util.Map)
    */
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int updMstCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			String strResCd = "";   //처리결과(A:승인, R:반려)
			String strReqType = ""; //요청구분(N:신규, C:교체, M:이동, R:반납)
			String strDesEqNo = ""; //처리 자산관리번호

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += equipmentRequestDAO.insert(rowData);
				
				strResCd = LimsUtil.checkNull(rowData.get("resCd"));
				strReqType = LimsUtil.checkNull(rowData.get("reqType"));
				strDesEqNo = LimsUtil.checkNull(rowData.get("desEqNo"));
				
				//요청승인
				if("A".equals(strResCd)) {

					//이력생성(AMS_EQ_HIST)
					Map<String, Object> inParam = new HashMap<String, Object>();
					Map<String, Object> retVal = new HashMap<String, Object>();				
					String callProcName = "AMS_EQ_HIST_PROCESS_PRO";
					//신규
					if("N".equals(strReqType)) {
						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("desEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 신규 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}
					}					
					//교체
					if("C".equals(strReqType)) {
						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("desEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 교체 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}

						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("srcEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 교체 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}
					}					
					//반납
					if("R".equals(strReqType)) {
						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("srcEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 반납 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}
					}					
					//이동
					if("M".equals(strReqType)) {
						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("srcEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 이동 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}
					}					
					//이력생성(AMS_EQ_HIST)
					
					//신규,교체요청
					if("N".equals(strReqType) || "C".equals(strReqType)) {
						//전산장비마스터 장비상태(=지급), 귀속업장(=요청업장), 귀속사용자(=요청자) 업데이트
						//교체요청일 경우 기존 장비상태(=재고) 업데이트
						updMstCnt += equipmentRequestDAO.updateMstA(rowData);
					}
					//교체,반납요청
					if("C".equals(strReqType) || "R".equals(strReqType)) {
						//기존 장비상태(=재고) 업데이트
						updMstCnt += equipmentRequestDAO.updateMstB(rowData);
					}
					//이동요청
					if("M".equals(strReqType)) {
						//기존 장비 귀속업장(=요청업장), 귀속사용자(=요청자) 업데이트
						updMstCnt += equipmentRequestDAO.updateMstC(rowData);
					}
					
				}

			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += equipmentRequestDAO.update(rowData);

				strResCd = LimsUtil.checkNull(rowData.get("resCd"));
				strReqType = LimsUtil.checkNull(rowData.get("reqType"));
				strDesEqNo = LimsUtil.checkNull(rowData.get("desEqNo"));
				
				//요청승인
				if("A".equals(strResCd)) {

					//이력생성(AMS_EQ_HIST)
					Map<String, Object> inParam = new HashMap<String, Object>();
					Map<String, Object> retVal = new HashMap<String, Object>();				
					String callProcName = "AMS_EQ_HIST_PROCESS_PRO";
					//신규
					if("N".equals(strReqType)) {
						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("desEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 신규 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}
					}					
					//교체
					if("C".equals(strReqType)) {
						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("desEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 교체 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}

						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("srcEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 교체 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}
					}					
					//반납
					if("R".equals(strReqType)) {
						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("srcEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 반납 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}
					}					
					//이동
					if("M".equals(strReqType)) {
						inParam.put("P_EQ_NO", LimsUtil.checkNull(rowData.get("srcEqNo")));
						inParam.put("P_CHG_GUBUN", "승인");
						inParam.put("P_CHG_TEXT", "전산장비 이동 요청 승인");
						inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));

						retVal = equipmentRequestDAO.callAmsProcedure(inParam, callProcName);						

						// 프로시저 실패시 롤백
						if("FALSE".equals(retVal.get("O_RTN").toString())){
							throw new BizException(retVal.get("O_RTNMSG").toString());
						}
					}					
					//이력생성(AMS_EQ_HIST)

					//신규,교체요청
					if("N".equals(strReqType) || "C".equals(strReqType)) {
						//전산장비마스터 장비상태(=지급), 귀속업장(=요청업장), 귀속사용자(=요청자) 업데이트
						//교체요청일 경우 기존 장비상태(=재고) 업데이트
						updMstCnt += equipmentRequestDAO.updateMstA(rowData);
					}
					//교체,반납요청
					if("C".equals(strReqType) || "R".equals(strReqType)) {
						//기존 장비상태(=재고) 업데이트
						updMstCnt += equipmentRequestDAO.updateMstB(rowData);
					}
					//이동요청
					if("M".equals(strReqType)) {
						//기존 장비 귀속업장(=요청업장), 귀속사용자(=요청자) 업데이트
						updMstCnt += equipmentRequestDAO.updateMstC(rowData);
					}
				}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += equipmentRequestDAO.delete(rowData);
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
     * @see com.hwfs.am.ams.service.EquipmentRequestService#selectEqList(java.util.Map)
    */
    @Override
    public RecordSet selectEqList(Map<String, Object> mapParam) throws Exception {
        return equipmentRequestDAO.selectEqList(mapParam);
    }
	
}