package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsf.dao.FuneralDeadRegDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 장례식장 관리하는 FuneralDeadReg Service Implementation
 * 
 * @ClassName FuneralDeadRegServiceImpl.java
 * @Description FuneralDeadRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsf/funeralDeadRegService")
public class FuneralDeadRegServiceImpl extends DefaultServiceImpl implements FuneralDeadRegService {
	
	/** FuneralDeadRegDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralDeadRegDAO")
	private FuneralDeadRegDAO funeralDeadRegDAO;
	
	/**
	 * 장례식장 관리 목록을 조회한다.
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
	public RecordSet selectFuneralDeadRegInfo(Map<String, Object> mapParam) throws Exception {
		return funeralDeadRegDAO.selectFuneralDeadRegInfo(mapParam);
	}
	
	/**
	 * 장례식장 대기자 목록을 조회한다.
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
	public RecordSet selectReservMaster(Map<String, Object> mapParam) throws Exception {
		return funeralDeadRegDAO.selectReservMaster(mapParam);
	}
	
	/**
	 * 호실변경 이력을 조회한다.
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
	public RecordSet selectFuneralParlorHistory(Map<String, Object> mapParam) throws Exception {
		return funeralDeadRegDAO.selectFuneralParlorHistory(mapParam);
	}
	
	/**
	 * 호실 변경 팝업을 조회한다.
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
	public RecordSet selectFuneralRoomNumberChg(Map<String, Object> mapParam) throws Exception {
		return funeralDeadRegDAO.selectFuneralRoomNumberChg(mapParam);
	}
	
	
	/**
	 * 호실 변경 팝업 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveFuneralRoomNumberChg(DataSetMap list) throws Exception {
		String curMaxNum = null;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				curMaxNum = funeralDeadRegDAO.selectMaxSeq(rowData).getRecord(0).get("maxNum").toString();
				rowData.put("seq", curMaxNum);
				insRowCnt += funeralDeadRegDAO.insertFuneralRoomNumberChg(rowData);	// 고인 호실변경 이력 입력				
				funeralDeadRegDAO.updateFuneralMaster(rowData);		// 고인Master 호실변경 update
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralDeadRegDAO.updateFuneralRoomNumberChg(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralDeadRegDAO.deleteFuneralRoomNumberChg(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 대기자 리스트 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveReservMaster(DataSetMap list) throws Exception {
		
		String curMaxNum = null;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				curMaxNum = funeralDeadRegDAO.selectMaxNum(rowData).getRecord(0).get("maxNum").toString();
				rowData.put("seq", curMaxNum);
				insRowCnt += funeralDeadRegDAO.insertReservMaster(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralDeadRegDAO.updateReservMaster(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralDeadRegDAO.deleteReservMaster(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
