package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponSpeciesPopDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 쿠폰종류 등록 관리팝업하는 couponSpeciesPop Service Implementation
 * 
 * @ClassName couponSpeciesPopServiceImpl.java
 * @Description couponSpeciesPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponSpeciesPopService")
public class CouponSpeciesPopServiceImpl extends DefaultServiceImpl implements CouponSpeciesPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** couponSpeciesPopDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponSpeciesPopDAO")
	private CouponSpeciesPopDAO couponSpeciesPopDAO;
	

	/**
	 * 쿠폰종류 등록 관리팝업 목록을 조회한다.
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
		return couponSpeciesPopDAO.selectList(mapParam);
	}

	/**
	 * 쿠폰종류 코드 중복 체크 조회한다.
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
	public RecordSet selectKindCount(Map<String, Object> mapParam) throws Exception {
		return couponSpeciesPopDAO.selectKindCount(mapParam);
	}

	/**
	 * 쿠폰종류 등록 관리팝업 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, DataSetMap upjanglist) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		
		//카드종류 저장 처리
		String couponKindCd = "";
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += couponSpeciesPopDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += couponSpeciesPopDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += couponSpeciesPopDAO.delete(rowData);
			}
			//기존 업장 정보 삭제
			if(i==0){
				couponKindCd = rowData.get("couponKindCd").toString();
				couponSpeciesPopDAO.deleteUpjang(rowData);
			}
		}
		//업장 정보 저장
		for (int i = 0 ; i < upjanglist.size() ; i++) {
			Map<String, Object> rowDataUpjang = upjanglist.get(i);

			if (rowDataUpjang.get("chk").toString().equals("1")) {
				rowDataUpjang.put("couponKindCd", couponKindCd);
				insRowCnt += couponSpeciesPopDAO.insertUpjang(rowDataUpjang);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 쿠폰종류관리 사용 가능 업장목록을 조회한다.
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
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return couponSpeciesPopDAO.selectUpjang(mapParam);
	}	
}
