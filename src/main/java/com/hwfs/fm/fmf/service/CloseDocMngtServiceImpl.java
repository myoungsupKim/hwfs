package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmf.dao.CloseDocMngtDAO;
import com.hwfs.fm.fmf.dao.SaleSumYearDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 월별매출집계 Service Implementation
 * 
 * @ClassName CloseDocMngtServiceImpl.java
 * @Description CloseDocMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일                  수정자                수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.15     dev03	      최초생성
 * </pre>
 * @author dev03
 * @since 2021.09.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmf/closeDocMngtService")
public class CloseDocMngtServiceImpl extends DefaultServiceImpl implements CloseDocMngtService {
	
	/** CloseDocMngtDAO Bean 생성 */
	@Resource(name = "/fm/fmf/closeDocMngtDAO")
	private CloseDocMngtDAO closeDocMngtDAO;
	

	/**
	 * 월별매출집계 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectList(mapParam);
	}

	/**
	 * 마감장관리(브랜드)(TOBE) 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectList2(mapParam);
	}



	/**
	 * selectSubList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.CloseDocMngtService#selectSubList(java.util.Map)
	*/
	@Override
	public RecordSet selectSubList(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectSubList(mapParam);
	}


	/**
	 * selectSubByOrder1List 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.CloseDocMngtService#selectSubByOrder1List(java.util.Map)
	*/
	@Override
	public RecordSet selectSubByOrder1List(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectSubByOrder1List(mapParam);
	}


	/**
	 * selectSubByOrderNList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.CloseDocMngtService#selectSubByOrderNList(java.util.Map)
	*/
	@Override
	public RecordSet selectSubByOrderNList(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectSubByOrderNList(mapParam);
	}


	/**
	 * selectSubByDateList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.CloseDocMngtService#selectSubByDateList(java.util.Map)
	*/
	@Override
	public RecordSet selectSubByDateList(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectSubByDateList(mapParam);
	}
	

	/**
	 * 마감장관리(브랜드)(TOBE) selectSubList2 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.CloseDocMngtService#selectSubList(java.util.Map)
	*/
	@Override
	public RecordSet selectSubList2(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectSubList2(mapParam);
	}


	/**
	 * 마감장관리(브랜드)(TOBE) selectSubByOrder1List2 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.CloseDocMngtService#selectSubByOrder1List(java.util.Map)
	*/
	@Override
	public RecordSet selectSubByOrder1List2(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectSubByOrder1List2(mapParam);
	}


	/**
	 * 마감장관리(브랜드)(TOBE) selectSubByOrderNList2 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.CloseDocMngtService#selectSubByOrderNList(java.util.Map)
	*/
	@Override
	public RecordSet selectSubByOrderNList2(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectSubByOrderNList2(mapParam);
	}


	/**
	 * 마감장관리(브랜드)(TOBE) selectSubByDateList2 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.CloseDocMngtService#selectSubByDateList(java.util.Map)
	*/
	@Override
	public RecordSet selectSubByDateList2(Map<String, Object> mapParam) throws Exception {
		return closeDocMngtDAO.selectSubByDateList2(mapParam);
	}
}
