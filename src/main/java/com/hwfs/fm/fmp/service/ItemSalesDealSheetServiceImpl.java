package com.hwfs.fm.fmp.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmp.dao.ItemSalesDealSheetDAO;
import com.hwfs.sc.cmn.util.DateUtil;
import com.hwfs.sc.cmn.util.StringUtil;
import com.sz.business.BusinessRuntimeException;

 /**
 * 
 * @ClassName ItemSalesDealSheetServiceImpl.java
 * @Description ItemSalesDealSheetServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.01    안종남        최초생성
 * </pre>
 * @author 안종남
 * @since 2015.07.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmp/itemSalesDealSheetService")
public class ItemSalesDealSheetServiceImpl extends DefaultServiceImpl implements ItemSalesDealSheetService {

	/**  Bean 생성 */
    @Resource(name = "/fm/fmp/itemSalesDealSheetDAO")
    private ItemSalesDealSheetDAO itemSalesDealSheetDAO;

    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectUpjangForCenter2(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectUpjangForCenter2(parameter);
    } 
    
   /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectSuvinvForUpjang(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectSuvinvForUpjang(parameter);
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectUpjangForCenter(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectUpjangForCenter(parameter);
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectCheckPurchase(Map<String, Object> parameter) throws Exception {
// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
//    	int gapDays   = 0;
		String frDate = parameter.get("frDate").toString();
		String toDate = parameter.get("toDate").toString();
		
//		gapDays = DateUtil.getGapForDay(frDate, toDate) + 1;  // 종료일 포함

//		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		// 입고일자 기간은 최대 31일
//		if ( gapDays > 31 ) {
//			throw new BusinessRuntimeException("입고일자 조회기간은 31이하로 하십시오.");
//		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 센터(조회조건)
		parameter.put("schCode", StringUtil.getWhereInQuery(parameter.get("schCode").toString()));
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 입고일자 조회 기간이 동일 할 경우
		if ( frDate.equals(toDate) ) {
			return itemSalesDealSheetDAO.selectCheckPurchase(parameter);

		// 구간 조회할 경우
		} else {
			String[] dueList       = DateUtil.getDtLit(frDate, toDate, DateUtil.MODE_BOTH_SIDES);
			String pivot_in_clause = StringUtil.concatStrListByDelim(",", dueList);
			
			parameter.put("pivot_in_clause", pivot_in_clause);
			return itemSalesDealSheetDAO.selectCheckPurchase2(parameter);
		}
// [속도개선 Project   끝] 2017. 7. 11. 최범주    	
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectCenter(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectCenter(parameter);
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectMuInfo(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectMuInfo(parameter);
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectDeptInfo(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectDeptInfo(parameter);
    }
    
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectMuCdForUpjang(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectMuCdForUpjang(parameter);
    }
    
    /**
     * controller에 정의 
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectUpjangForSabun(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectUpjangForSabun(parameter);
    }
    
// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
    /**
     * controller에 정의 
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectTitleInfo(Map<String, Object> parameter) throws Exception {
        return itemSalesDealSheetDAO.selectTitleInfo(parameter);
    }
    
    /**
     * controller에 정의 
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet searchBaseDt(Map<String, Object> parameter) throws Exception {
    	return itemSalesDealSheetDAO.searchBaseDt(parameter);
    }
// [속도개선 Project   끝] 2017. 7. 11. 최범주
}
