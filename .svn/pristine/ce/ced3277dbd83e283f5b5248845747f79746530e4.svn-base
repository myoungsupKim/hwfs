package com.hwfs.sc.scc.web;

import hone.core.cache.CacheItemInfo;
import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.service.ComCacheService;
import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.sc.cmn.util.DateUtil;
import com.tobesoft.xplatform.data.DataSet;


 /**
 * Cache정보를 관리하는 CacheMgmt Controller
 * 
 * @ClassName CacheMgmtController.java
 * @Description CacheMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.11    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.05.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scc/cacheMgmt/")
public class CacheMgmtController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	@Autowired
	private ComCacheService cacheService;

	/**
	 * Cache 정보 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

//    	//Cache 테스트용
//    	String cacheId = "TEST-AA";
//    	String cacheVal;
//    	if(cacheService.contains(cacheId)) {
//    		cacheVal = (String) cacheService.get(cacheId, String.class);
//    	}
//    	else {
//    		cacheVal = "TEST_AA Value";
//    		cacheService.put(cacheId, cacheVal);
//    	}
//
//    	cacheId = "TEST-BB";
//    	Map<String, Object> cacheVal2 = new HashMap<String, Object>();
//    	if(cacheService.contains(cacheId)) {
//    		cacheVal2 = (Map) cacheService.get(cacheId, Map.class);
//    	}
//    	else {
//    		cacheVal2.put("1", "data1");
//    		cacheVal2.put("2", 123);
//    		cacheService.put(cacheId, cacheVal2);
//    	}

		//Cache 정보 을(를) 조회한다.
    	List<CacheItemInfo> cacheItemInfoList = cacheService.getCacheItemInfoList();

    	//Cache 정보를 화면에 표시하기 위한 형태로 변환한다. 
    	List<Map<String, Object>> listInfo = new ArrayList<Map<String, Object>>();
    	for (CacheItemInfo cacheItemInfo : cacheItemInfoList) {
    		Map<String, Object> map = new HashMap<String, Object>();
    		
    		String cacheKey = (String) cacheItemInfo.getCacheKey();
    		map.put("cacheKey", cacheKey);
    		map.put("cacheName", cacheItemInfo.getCacheName());
    		Object objVal = cacheService.get(cacheKey, Object.class);
    		if (objVal instanceof RecordSet)
    			map.put("cacheValue", DTOUtil.convertRecordToMapList((RecordSet)objVal));
    		else if (objVal instanceof Record)
    			map.put("cacheValue", DTOUtil.convertRecordToMap((Record)objVal));
    		else
    			map.put("cacheValue", cacheService.get(cacheKey, Object.class));
    		
    		map.put("creationTime", DateUtil.getYyyymmddhhmmss(cacheItemInfo.getCreationTime()));
    		map.put("lastAccessTime", DateUtil.getYyyymmddhhmmss(cacheItemInfo.getLastAccessTime()));
    		map.put("lastUpdateTime", DateUtil.getYyyymmddhhmmss(cacheItemInfo.getLastUpdateTime()));
    		
    		listInfo.add(map);
    	}

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", listInfo);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * Cache 정보(을)를 Delete 처리한다.
	 * <pre>
	 * - 메모리 캐시에서 삭제한다.
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap list = param.get("ds_list");

		//Cache 정보을(를) 삭제 처리한다.
		int processCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			@SuppressWarnings("unchecked")
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Delete 처리.
			if (rowType == DataSet.ROW_TYPE_DELETED) {
				String cacheKey = rowData.get("cacheKey").toString();
				if(cacheService.contains(cacheKey)) {
					cacheService.removeCacheItem(cacheKey);
					processCnt++;
					logger.info("Cache Item is deleted!![{}]", cacheKey);
				}
			}
		}

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
