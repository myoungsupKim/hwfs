package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.ReceiveMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 입금관리하는 ReceiveMgnt Service Implementation
 * 
 * @ClassName ReceiveMgntServiceImpl.java
 * @Description ReceiveMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/receiveMgntService")
public class ReceiveMgntServiceImpl extends DefaultServiceImpl implements ReceiveMgntService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ReceiveMgntDAO Bean 생성 */
	@Resource(name = "/sm/sar/receiveMgntDAO")
	private ReceiveMgntDAO receiveMgntDAO;
	

	/**
	 * 입금관리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.selectList(mapParam);
	}
	
	/**
	 * 상계/대체 처리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBTList01(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.selectBTList01(mapParam);
	}

	public RecordSet selectBTList02(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.selectBTList02(mapParam);
	}
	
	//전표처리 개수
	public RecordSet selectJcnt(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.selectJcnt(mapParam);
	}
	public RecordSet selectJcnt2(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.selectJcnt2(mapParam);
	}

	//월마감 확인
	public RecordSet chkClose(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.chkClose(mapParam);
	}
	
	/**
	 * 입금관리상세 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	//(선수금선매출)
	public RecordSet selectDetailList1(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.selectDetailList1(mapParam);
	}
	//가수금
	public RecordSet selectDetailList2(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.selectDetailList2(mapParam);
	}
	//신용카드결재
	public RecordSet selectDetailList3(Map<String, Object> mapParam) throws Exception {
		return receiveMgntDAO.selectDetailList3(mapParam);
	}

	/**
	 * 입금관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
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
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += receiveMgntDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += receiveMgntDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += receiveMgntDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 마이너스 상계 DataSetMap의 데이터를 rowType에 따라 Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int batchDelete(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		int updRowCnt = 0;
		
		Map<String, Object> rowData = list.get(0);

		//Update 처리.
		//채권 마스터(대체내역 CUSER : SYSTEM-ST1제외하고 입금금액 업데이트)
		updRowCnt += receiveMgntDAO.batchUpdate(rowData);
		
		//Delete 처리.	
		//채권 입금 지불수단
		delRowCnt += receiveMgntDAO.batchDelete1(rowData);
		//채권 입금 상세
		delRowCnt += receiveMgntDAO.batchDelete2(rowData);
		//채권 입금 마스터
		delRowCnt += receiveMgntDAO.batchDelete3(rowData);
		
	
				
		return updRowCnt;
	}
	
	/**
	 * 플러스채권 대체 DataSetMap의 데이터를 rowType에 따라 Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int batchDelete2(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		int updRowCnt = 0;
		
		Map<String, Object> rowData = list.get(0);
		
		//Update 처리.	
		//선수금 마스터(대체내역 CUSER : SYSTEM-ST2제외하고 대체금액 업데이트)
		updRowCnt += receiveMgntDAO.batchUpdate2(rowData);
		//채권 마스터(대체내역 CUSER : SYSTEM-ST2제외하고 입금금액 업데이트)
		updRowCnt += receiveMgntDAO.batchUpdate3(rowData);
	
		
		//Delete 처리.	
		//채권 입금 지불수단
		delRowCnt += receiveMgntDAO.batchDelete5(rowData);
		//채권 입금 상세
		delRowCnt += receiveMgntDAO.batchDelete6(rowData);
		//채권 입금 마스터
		delRowCnt += receiveMgntDAO.batchDelete7(rowData);
		//선수금대체 상세
		delRowCnt += receiveMgntDAO.batchDelete8(rowData);
		//선수금대체 마스터
		delRowCnt += receiveMgntDAO.batchDelete9(rowData);
		
				
		return updRowCnt;
	}
}
