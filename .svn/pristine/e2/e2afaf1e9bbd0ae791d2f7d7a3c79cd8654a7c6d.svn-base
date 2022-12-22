package com.hwfs.sc.cmn.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import zipit.rfnCustCommonAddrList;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.sc.cmn.service.AddrSearchService;

/**
 * 주소검색을하는 AddrSearch Controller
 *
 * @ClassName AddrSearchController.java
 * @Description AddrSearchController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.09
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/addrSearch/")
public class AddrSearchController extends DefaultController {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** AddrSearchService Bean 생성 */
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addrSearchService;

	/**
	 * 도로명 조건에 대한 시도 목록을 조회한다.
	 *
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectSidoList.xdo")
	public ModelAndView selectSidoList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		// Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = addrSearchService.selectSidoList();

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_cbo_sido", rs);
		super.addOutVariable(mav, "fv_uuid", UUIdGenUtil.getUUID()
				.toUpperCase());

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("selectNewKey.xdo")
	public ModelAndView selectNewKey(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		super.addOutVariable(mav, "fv_newKey", UUIdGenUtil.getUUID()
				.toUpperCase());

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 도로명 조건에 대한 시도 목록을 조회한다.
	 *
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectGugunList.xdo")
	public ModelAndView selectGugunList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = addrSearchService.selectGugunList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_cbo_gugun", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조건에 맞는 도로명 주소를 조회한다.
	 *
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectRoadList.xdo")
	public ModelAndView selectRoadList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = addrSearchService.selectRoadList(parameter.get(
				"ds_searchRoad").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listRoad", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조건에 맞는 지번 주소를 조회한다.
	 *
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectJibunList.xdo")
	public ModelAndView selectJibunList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = addrSearchService.selectJibunList(parameter.get(
				"ds_searchJibun").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listJibun", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조건에 맞는 지번 주소를 조회한다.
	 *
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("confirmAddress.xdo")
	public ModelAndView confirmAddress(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		// XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		rfnCustCommonAddrList addressConfirm = new rfnCustCommonAddrList();

		Map searchResult = addressConfirm.getRfnAddrMap(parameter
				.get("zipCode").toString(), parameter.get("baseAddr")
				.toString(), parameter.get("detailAddr").toString(),
				super.propertiesService.getString("addr.search.encoding"),
				super.propertiesService.getString("addr.search.flag"));

		List<Map<String, String>> lstResult = new ArrayList<Map<String, String>>();
		String confirmYn = "";

		// 주소의 정제결과가 1:1 매칭될 경우에는 1번째(자식노드)의 주소를 사용한다.
		if ("I".equals(searchResult.get("RCD3").toString())
				|| "H".equals(searchResult.get("RCD3").toString())) {
			Map<String, String> search = ((List<Map<String, String>>) searchResult
					.get("DATA")).get(1);
			Map<String, String> result = new HashMap<String, String>();

			result.put("className1", "지번");
			result.put("zipCode1", search.get("ZPRNJ"));
			result.put("baseAddr1", search.get("ADDR1H"));
			result.put("detailAddr1", search.get("STDADDR"));
			result.put("lon1", search.get("GISX"));
			result.put("lat1", search.get("GISY"));

			result.put("className2", "도로명");
			result.put("zipCode2", search.get("ZPRNR"));
			result.put("baseAddr2", search.get("NADR1"));
			result.put("detailAddr2",
					search.get("NADR3") + search.get("NADREH"));
			result.put("lon2", search.get("NNMX"));
			result.put("lat2", search.get("NNMY"));
			result.put("buildingMgmtNum", search.get("NNMZ"));

			result.put("etcAddr", parameter.get("etcAddr").toString());
			result.put("confirmYn", "Y");
			confirmYn = "Y";
			lstResult.add(result);
		}
		// 여러개가 매칭되는 경우.
		else if ("C".equals(searchResult.get("RCD3").toString())
				|| "D".equals(searchResult.get("RCD3").toString())
				|| "E".equals(searchResult.get("RCD3").toString())
				|| "F".equals(searchResult.get("RCD3").toString())
				|| "G".equals(searchResult.get("RCD3").toString())) {

			List<Map<String, String>> lst = (List<Map<String, String>>) searchResult
					.get("DATA");

			for (int i = 0; i < lst.size(); i++) {
				Map<String, String> search = lst.get(i);

				if ("P".equals(search.get("NODE").toString())) {
					Map<String, String> result = new HashMap<String, String>();

					result.put("className1", "지번");
					result.put("zipCode1", search.get("ZPRNJ"));
					result.put("baseAddr1", search.get("ADDR1H"));
					result.put("detailAddr1", search.get("STDADDR"));
					result.put("lon1", search.get("GISX"));
					result.put("lat1", search.get("GISY"));

					result.put("className2", "도로명");
					result.put("zipCode2", search.get("ZPRNR"));
					result.put("baseAddr2", search.get("NADR1"));
					result.put("detailAddr2",
							search.get("NADR3") + search.get("NADREH"));
					result.put("lon2", search.get("NNMX"));
					result.put("lat2", search.get("NNMY"));
					result.put("buildingMgmtNum", search.get("NNMZ"));

					result.put("etcAddr", parameter.get("etcAddr").toString());
					result.put("confirmYn", "Y");
					confirmYn = "Y";
					lstResult.add(result);
				}
			}

		}
		// 지번 주소만 존재하는 경우
		else if ("6".equals(searchResult.get("RCD3").toString())
				|| "5".equals(searchResult.get("RCD3").toString())
				|| "8".equals(searchResult.get("RCD3").toString())) {
			Map<String, String> search = ((List<Map<String, String>>) searchResult
					.get("DATA")).get(1);
			Map<String, String> result = new HashMap<String, String>();

			result.put("className1", "지번");
			result.put("zipCode1", search.get("ZPRNJ"));
			result.put("baseAddr1", search.get("ADDR1H"));
			result.put("detailAddr1", search.get("STDADDR"));
			result.put("lon1", search.get("GISX"));
			result.put("lat1", search.get("GISY"));

			result.put("className2", "도로명");
			result.put("zipCode2", search.get("ZPRNR"));
			result.put("baseAddr2", search.get("NADR1"));
			result.put("detailAddr2",
					search.get("NADR3") + search.get("NADREH"));
			result.put("lon2", search.get("NNMX"));
			result.put("lat2", search.get("NNMY"));
			result.put("buildingMgmtNum", search.get("NNMZ"));

			result.put("etcAddr", parameter.get("etcAddr").toString());
			result.put("confirmYn", "Y");
			confirmYn = "Y";
			lstResult.add(result);
		}
		// 에러발생
		else if ("1".equals(searchResult.get("RCD3").toString())
				|| "2".equals(searchResult.get("RCD3").toString())
				|| "3".equals(searchResult.get("RCD3").toString())
				|| "4".equals(searchResult.get("RCD3").toString())
				//|| "5".equals(searchResult.get("RCD3").toString())
				|| "7".equals(searchResult.get("RCD3").toString())
				|| "9".equals(searchResult.get("RCD3").toString())
				|| "A".equals(searchResult.get("RCD3").toString())
				|| "B".equals(searchResult.get("RCD3").toString())
				|| "J".equals(searchResult.get("RCD3").toString())
				|| "K".equals(searchResult.get("RCD3").toString())
				|| "L".equals(searchResult.get("RCD3").toString())
				|| "M".equals(searchResult.get("RCD3").toString())
				|| "N".equals(searchResult.get("RCD3").toString())
				|| "O".equals(searchResult.get("RCD3").toString())) {
			confirmYn = "N";
		}

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_searchAddress", lstResult);
		super.addOutVariable(mav, "fv_confirmYn", confirmYn);
		super.addOutVariable(mav, "fv_search_message", searchResult.get("RMG3"));

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
