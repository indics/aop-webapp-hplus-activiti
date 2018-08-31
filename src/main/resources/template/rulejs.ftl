Namespace.register("com.cosim.form.rule");  
com.cosim.form.rule.CustomRules=[<#list	ruleList as rule>
	{
		name:"${rule.name}",
		rule:function(v){
				return /${rule.rule}/.test(v);
		},
		msg:"${rule.tipInfo}"
	}<#if rule_has_next>,</#if>
</#list>];
