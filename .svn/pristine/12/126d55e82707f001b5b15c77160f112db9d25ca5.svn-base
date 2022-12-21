/*
 * Copyright 2001-2007 by HANWHA S&C Corp.,
 * All rights reserved.
 * 
 * This software is the confidential and proprietary information
 * of HANWHA S&C Corp. ("Confidential Information").  You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with HANWHA S&C Corp.
 */
/** 
 * @fileoverview 결재 Agent 패키지
 *
 * @author 박성수 <a href="mailto:ghbpark@hanwha.co.kr">ghbpark@hanwha.co.kr</a>
 * @version 2.0 
 */
if (typeof hanwha == "undefined") {
    var hanwha = {};
}
hanwha.namespace = function() {
    var a=arguments, o=null, i, j, d;
    for (i=0; i<a.length; i=i+1) {
        d=a[i].split(".");
        o=hanwha;
        for (j=(d[0] == "hanwha") ? 1 : 0; j<d.length; j=j+1) {
            o[d[j]]=o[d[j]] || {};
            o=o[d[j]];
        }
    }
    return o;
};
(function() {
    hanwha.namespace("approval", "util", "commons");
})();