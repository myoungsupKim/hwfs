package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.sc.cmn.dao.AddrSearchDAO;
import com.hwfs.sc.scc.service.ParameterLogService;

 /**
 * 주소검색을하는 AddrSearch Service Implementation
 *
 * @ClassName AddrSearchServiceImpl.java
 * @Description AddrSearchServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.09
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/addrSearchService")
public class AddrSearchServiceImpl extends DefaultServiceImpl implements AddrSearchService {
	/** AddrSearchDAO Bean 생성 */
	@Resource(name = "/sc/cmn/addrSearchDAO")
	private AddrSearchDAO addrSearchDAO;

	@Resource(name="/sc/scc/parameterLogService")
	private ParameterLogService parameterLog;

	/**
	 * 도로명 주소에 대한 시도 조건 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.service.ZipSearchService#selectSidoList()
	 */
	@Override
	public RecordSet selectSidoList() throws Exception {
		return addrSearchDAO.selectSidoList();
	}

	/**
	 * 도로명 주소에 대한 시구군 조건 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ZipSearchService#selectGugunList(java.util.Map)
	 */
	@Override
	public RecordSet selectGugunList(Map<String, Object> parameter) throws Exception {
		return addrSearchDAO.selectGugunList(parameter);
	}

	/**
	 * 조건에 맞는 도로명 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ZipSearchService#selectRoadList(java.util.Map)
	 */
	@Override
	public RecordSet selectRoadList(Map<String, Object> parameter) throws Exception {
		return addrSearchDAO.selectRoadList(parameter);
	}

	/**
	 * 조건에 맞는 지번 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ZipSearchService#selectJibunList(java.util.Map)
	 */
	@Override
	public RecordSet selectJibunList(Map<String, Object> parameter) throws Exception {
		return addrSearchDAO.selectJibunList(parameter);
	}

	/**
	 * 주소정보를 처리한다.
	 *
	 * @param parameter
	 * @param bindAddressKey
	 * @param bindSabunKey
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.AddrSearchService#setAddress(java.util.Map, java.lang.String, java.lang.String)
	*/
	@Override
	public Map<String, Object> setAddress(Map<String, Object> parameter, String bindAddressKey, String sabun) throws Exception {
		String logKey = UUIdGenUtil.getUUID();
		try {
			if (parameter.containsKey(bindAddressKey) && !"".equals(parameter.get(bindAddressKey))) {
				parameterLog.setLog(logKey, "ADDRESS", "[" + sabun + "] / " + parameter.get(bindAddressKey).toString());
				Map<String, Object> p = new HashMap<String, Object>();
				p.put("V_ADDR_INFO", parameter.get(bindAddressKey));
				p.put("V_SABUN", sabun);
	
				return addrSearchDAO.setAddress(p);
			}
			else {
				return null;
			}
		}
		catch (Exception ept) {
			parameterLog.setLog(logKey, "ADDRESS", "[" + sabun + "] / " + ept.getMessage());
			return null;
		}
	}
}
