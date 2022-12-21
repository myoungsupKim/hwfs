package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponCreateDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 쿠폰 생성 관리하는 CouponCreate Service Implementation
 * 
 * @ClassName CouponCreateServiceImpl.java
 * @Description CouponCreateServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.20    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponCreateService")
public class CouponCreateServiceImpl extends DefaultServiceImpl implements CouponCreateService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponCreateDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponCreateDAO")
	private CouponCreateDAO couponCreateDAO;
	

	/**
	 * 쿠폰 생성 관리 목록을 조회한다.
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
		return couponCreateDAO.selectList(mapParam);
	}

	/**
	 * 쿠폰 생성 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveList(DataSetMap list) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += couponCreateDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += couponCreateDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				int delCnt = couponCreateDAO.delCnt(rowData);
				if(delCnt == 0){
					delRowCnt += couponCreateDAO.delete(rowData);//PUBLISH 상태 D 업데이트.
					couponCreateDAO.couponStatusUpdate(rowData);//쿠폰 폐기처리.
					rtn.put("del", "succ");
				}else{
					rtn.put("del", "fail");
				}
			}
		}
		rtn.put("cnt", insRowCnt + updRowCnt + delRowCnt);
		return rtn;
	}

	/**
	 * 쿠폰 생성 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int createProc(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//먼저 UPDATE 처리를 한다
			updRowCnt += couponCreateDAO.update(rowData);
			
			//번호를 create 처리 한다.
			insRowCnt += couponCreateDAO.create(rowData);
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 쿠폰 미생성된 중복 번호를 체크 한다.
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
	public int selectCouponNumCount(Map<String, Object> mapParam) throws Exception {
		return couponCreateDAO.selectCouponNumCount(mapParam);
	}

	/**
	 * 쿠폰 번호를 조회 한다.
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
	public RecordSet selectCouponNum(Map<String, Object> mapParam) throws Exception {
		return couponCreateDAO.selectCouponNum(mapParam);
	}
	
	/**
	 * 쿠폰 번호가 중복인지 조회 한다.
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
	public int couponSearch(Map<String, Object> mapParam) throws Exception {
		int couponCnt = 0;
		return couponCnt = couponCreateDAO.selectCouponCnt(mapParam);
	}

	
}
