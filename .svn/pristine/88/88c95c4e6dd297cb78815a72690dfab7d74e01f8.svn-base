package com.hwfs.sc.scp.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sc.scp.dao.PersDstryHistDAO;
import com.hwfs.sc.scp.dao.PersDstryReqDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 개인정보 파기요청을 관리하는 PersDstryReq Service Implementation
 * 
 * @ClassName PersDstryReqServiceImpl.java
 * @Description PersDstryReqServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scp/persDstryReqService")
public class PersDstryReqServiceImpl extends DefaultServiceImpl implements PersDstryReqService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PersDstryReqDAO Bean 생성 */
	@Resource(name = "/sc/scp/persDstryReqDAO")
	private PersDstryReqDAO persDstryReqDAO;

	/** PersDstryHistDAO Bean 생성 */
	@Resource(name = "/sc/scp/persDstryHistDAO")
	private PersDstryHistDAO persDstryHistDAO;

	/** GwIfDAO Bean 생성 */
	@Resource(name = "/sc/cmn/gwIfDAO")
	private GwIfDAO gwIfDAO;
	

	/**
	 * 개인정보 파기요청 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return persDstryReqDAO.selectList(mapParam);
	}

	/**
	 * 개인정보 파기요청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			logger.info("PersDstryReqServiceImpl.saveList={}", rowData);
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//이미 등록된 건이 있는지 검사한다.
				if (persDstryReqDAO.selectAlreadyExistsCnt(rowData) > 0) {
					throw super.processException("sc.scp.dstry.req.already.exists", new Object[]{rowData.get("dstryUserNm")});
				}
				insRowCnt += persDstryReqDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += persDstryReqDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += persDstryReqDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 개인정보 파기요청 상신 목록을 조회한다.
	 *
	 * @param list
	 *            조회조건 List<Map>
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public List<Record> selectGwDraftList(List<Map<String, Object>> list) throws Exception {
		List<Record> listRecord = new ArrayList<Record>();
		for (int i=0; i < list.size(); i++) {
			Record record = persDstryReqDAO.selectGwDraftList(list.get(i));
			if (record != null && !record.isEmpty())
				listRecord.add(record);
		}
		return listRecord;
	}

	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideSampleService#saveSign(hone.online.xplatform.map.DataSetMap)
	*/
	@Override
	public int saveSignInfo(DataSetMap list) throws Exception {
		int updateRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			@SuppressWarnings("unchecked")
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//수정을 수행합니다. (Update만 존재)
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				//업무 테이블에 결재INSTANCE_ID update
				updateRowCnt += persDstryReqDAO.updateSign(rowData);

				//SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
				gwIfDAO.saveSignInfo(rowData);
			}
		}

		return updateRowCnt;
	}

	/**
	 * 개인정보파기요청이 결재승인이 난 경우 개인정보파기이력 테이블에 Insert 처리한다.
	 * <pre>
	 * - 개인정보파기요청 테이블에서 결재승인 && 이력처리YN이 'Y'가 아닌 건에 대해서만 개인정보파기이력 테이블에 INSERT
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	public int insertPersDstryReqLog() throws Exception {
		//대상 건 조회
		RecordSet rs = persDstryReqDAO.selectPersDstryReqApprovForLog();

		int cnt = 0;
		for (int i=0; i<rs.size(); i++) {
			Map<String, Object> map = DTOUtil.convertRecordToMap(rs.get(i));
			//개인정보파기이력 테이블에 Insert 처리
			persDstryHistDAO.insert(map);
			
			//이력처리YN = 'Y'로 Update
			persDstryReqDAO.updateLogProcYn(map);
		}
		return cnt;
	}

}

