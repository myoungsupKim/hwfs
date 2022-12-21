package com.hwfs.sc.cmn.web;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.CryptoUtil;
import com.hwfs.rc.rcg.service.CouponMgntService;

@Controller
@RequestMapping("/sc/cmn/barCode/")
public class BarCodeController extends DefaultController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;
    
	/** CouponMgntService Bean 생성 */
	@Resource(name = "/rc/rcg/couponMgntService")
	private CouponMgntService couponMgntService;
    
	@RequestMapping(value = "selectCode.do")
	public ModelAndView selectCode ( HttpServletRequest request, Model model
									, @RequestParam(value = "code", required = true) String code
									, @RequestParam(value = "ofs", required = true) String offset ) throws Exception {

		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam.put("code", code);
		mapParam.put("ofs", offset);
		
		RecordSet rs = couponMgntService.selectCouponStatus(mapParam);
		
		model.addAttribute("type", "code127");
		model.addAttribute("code", code);
		model.addAttribute("attr01", rs.get(0).get("couponStatusNm").toString());
		model.addAttribute("etc02", rs.get(0).get("etc02").toString());
		
		//Viewer 설정		
    	ModelAndView mav = new ModelAndView();
		mav.setViewName("bc/coupon");
		return mav;
	}
	    
}
