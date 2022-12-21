package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.fs.fsf.dao.FuneralPatronMstRegDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 고인등록하는 FuneralPatronMstReg Service Implementation
 * 
 * @ClassName FuneralPatronMstRegServiceImpl.java
 * @Description FuneralPatronMstRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02    백정훈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 백정훈
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsf/funeralPatronMstRegService")
public class FuneralPatronMstRegServiceImpl extends DefaultServiceImpl implements FuneralPatronMstRegService {
	
	/** FuneralPatronMstRegDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralPatronMstRegDAO")
	private FuneralPatronMstRegDAO funeralPatronMstRegDAO;
	
	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;

	/**
	 * 고인Master 등록관리 화면 목록을 조회한다.
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
		return funeralPatronMstRegDAO.selectList(mapParam);
	}
	
	/**
	 * 고인 가족관리 등록관리 화면 목록을 조회한다.
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
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception {
		return funeralPatronMstRegDAO.selectDtlList(mapParam);
	}
	
	/**
	 * 장례식장코드에 대한, 고객번호의 순번 max+1 을 조회한다.(고인Master 채번)
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	
	public RecordSet selectMaxNum(String mapParam) throws Exception {
		return funeralPatronMstRegDAO.selectMaxNum(mapParam);
	}
	*/
	
	/**
     * 현재날짜를 다양한 포멧으로 리턴한다.
     *
     * @param type
     *            변경되어질 시간형식의 포멧
     *
     * 예) getDate("yyyyMMdd");
     * getDate("yyyyMMddHHmmss");
     * getDate("yyyy/MM/dd HH:mm:ss");
     * getDate("yyyy/MM/dd");
     * getDate("HHmm");
     */
    public String getCurDate(String type) {
        String returnValue;
        if (type == null) {
            return "";
        }
        returnValue = new SimpleDateFormat(type, Locale.KOREA).format(new Date());
        return returnValue;
    }

	/**
	 * 고인Master 등록관리 화면 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveList(Map<String, DataSetMap> mapParam,  String sabun) throws Exception {
		
		DataSetMap dsDeadInfoReg = mapParam.get("ds_deadInfoReg");
		DataSetMap dsChierMournerInfoReg = mapParam.get("ds_deadInfoReg");
		Map<String, Object> cond = new HashMap<String, Object>();
		String curHallCd = null;
		String curGuestNum = null;
		String curMaxNum = null;
	//	int dupCnt = 0;
		String rtnCnt = "0";
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("dupCnt", "0");
		
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i=0 ; i<dsDeadInfoReg.size(); i++) {
			Map<String, Object> rowData = dsDeadInfoReg.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			curHallCd = rowData.get("funeralHallCd").toString();	// 장례식장 코드
			curGuestNum = rowData.get("guestNum").toString();		// 고객번호
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				cond.put("funeralHallCd", curHallCd);
				cond.put("curDate", getCurDate("yyyyMMdd"));
				curMaxNum = funeralPatronMstRegDAO.selectMaxNum(cond).getRecord(0).get("maxNum").toString();
				if("0".equals(curMaxNum)) {
					rowData.put("guestNum", (getCurDate("yyyyMMdd")+1));
				}else {
					rowData.put("guestNum", (getCurDate("yyyyMMdd")+(Integer.parseInt(curMaxNum)+1)));
				}
				
				if("".equals(String.valueOf(rowData.get("borneOutDateTime")))) {
					rowData.put("borneOutDateTime", "000000");
				}
				if("".equals(String.valueOf(rowData.get("enshrineDateTime")))) {
					rowData.put("enshrineDateTime", "000000");
				}
				if("".equals(String.valueOf(rowData.get("casketDateTime")))) {
					rowData.put("casketDateTime", "000000");					
				}
				
				// 동일 일자, 동일 빈소 체크
				String dupCnt = funeralPatronMstRegDAO.selectIsDuplicate(rowData).getRecord(0).getString("dupCnt");
				
				if("0".equals(dupCnt)) {
					insRowCnt += funeralPatronMstRegDAO.insert(rowData);
					
				}else{
					rtnCnt = "1";
				}
				
			//Update 처리
			}else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				// 동일 일자, 동일 빈소 체크
				String dupCnt = funeralPatronMstRegDAO.selectIsDuplicate(rowData).getRecord(0).getString("dupCnt");
				
				if("0".equals(dupCnt)) {
					updRowCnt += funeralPatronMstRegDAO.update(rowData);
				}else{
					rtnCnt = "1";
				}
			
			//Delete 처리.
			}else if (rowType == DataSet.ROW_TYPE_DELETED) {
				
				for (int j=0 ; j<dsChierMournerInfoReg.size(); j++) {
					Map<String, Object> rowData2 = dsChierMournerInfoReg.get(j);
					int rowType2 = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
					
					if((rowType2 == DataSet.ROW_TYPE_DELETED)
							&& curHallCd.equals(rowData2.get("funeralHallCd"))
							&& curGuestNum.equals(rowData2.get("guestNum"))) {						
						//Delete 처리.
						delRowCnt += funeralPatronMstRegDAO.deleteDtl(rowData2);					
					}
				}
				
				delRowCnt += funeralPatronMstRegDAO.delete(rowData);
				
			}
		}
		
		for (int i=0 ; i<dsChierMournerInfoReg.size(); i++) {
			Map<String, Object> rowData = dsChierMournerInfoReg.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//주소 처리
			Map<String, Object> rtn = addressService.setAddress(rowData, "addrInfo", sabun);
			addressService.setAddress(rowData, "addrInfo2", sabun);
			
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				curMaxNum = funeralPatronMstRegDAO.selectMaxDtlNum(rowData).getRecord(0).get("maxNum").toString();
				rowData.put("seq", curMaxNum);
				insRowCnt += funeralPatronMstRegDAO.insertDtl(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralPatronMstRegDAO.updateDtl(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralPatronMstRegDAO.deleteDtl(rowData);
			}
		}
		
		rtnMap.put("dupCnt", rtnCnt);
		rtnMap.put("procCnt", insRowCnt + updRowCnt + delRowCnt);
		return rtnMap;
	}
	
	/**
	 * 고인및 상주상세정보 화면 목록을 조회한다.
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
	public RecordSet selectGuestDtlList(Map<String, Object> mapParam) throws Exception {
		return funeralPatronMstRegDAO.selectGuestDtlList(mapParam);
	}
}
