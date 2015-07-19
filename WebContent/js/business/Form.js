UF.business.Form = (function () {
	var labels = {
		store: 'data-store',	// store for combo
		textField: 'data-textField',	// text field for combo
		valueField: 'data-valueField',	// value field for combo
		regex: 'data-regex',	// string of regular expression for validating 
		regexName: 'data-regexName',	// name of regular expression for validating
		match: 'data-match',	// name of another field to which this one should match
		noValidate: 'data-novalidate',	// prevent validating
		autoValidate: 'data-autoValidate',	// Indicating the current form has been set up auto validating mechanism
		emptyMessage: 'msg-empty',	// error message when a required field is empty
		regexMessage: 'msg-regex',	// error message when the field fails in regular testing
		matchMessage: 'msg-match'	// error message when the field doesn't match the specified one
	};
	
	function is(obj, label) {
		return $(obj).is('[' + label + ']');
	}

	return {
		init: function () {
		    _.delay(function () {
		    	if (_.isObject(model)) UF.business.Form.renderModel(model);
		    	$('input').removeAttr('data-novalidate');
		    	$('select').removeAttr('data-novalidate');
		    }, 100);
		    
		    $('input').attr('data-novalidate', 'true');
		    $('select').attr('data-novalidate', 'true');
		    $('form').each(UF.business.Form.autoValidateForm);
		},
		loadSelect: function () {
			if ($(this).prop('tagName') != 'SELECT') return;
			
			var store = UF.stores[$(this).attr('data-store')];
			if (!_.isObject(store)) {
				console.log(this, 'Store not found.');
				return;
			}
			
			var textField = $(this).attr(labels.textField) || 'name';
			var valueField = $(this).attr(labels.valueField) || 'id';
			
			$(this).find('option:not([disabled])').remove();
			var _self = this;
			_.each(store, function (record) {
				$(_self).append($('<option>', { text: record[textField], value: record[valueField] }));
			});
			
			$(this).val('');
		},
		validate: function () {
			function clearError() {
				$(this).removeClass('invalid').siblings('.error').remove();
			}
			
			function addError(obj, msg) {
				$(obj).each(clearError);
				if (msg != null) {
					$(obj).addClass('invalid').attr('title', msg);
					$('<small>').addClass('error').html(msg).appendTo($(obj).parent());
				}
			}
			
			$(this).each(clearError);
			if (!$(this).is(':enabled:visible') || is(this, labels.noValidate)) return;
					
			var msg = null;
			var val = $(this).val();
			if ($(this).is('[required]') && (val == null || (_.isString(val) && val.length == 0))) {
				msg = $(this).attr('msg-empty') || '请填写本字段';
			}
			
			if (msg == null && (is(this, labels.regex) || is(this, labels.regexName))) {
				var regexString = $(this).attr(labels.regex) || UF.base.RegularExpressions[$(this).attr(labels.regexName)];
				if (_.isString(val) && !(new RegExp(regexString, 'i').test(val))) {
					// console.log(regexString, new RegExp(regexString, 'i'));
					msg = $(this).attr(labels.regexMessage);
				}
			}
			
			if (msg == null && is(this, labels.match)) {
				var matchField = $('[name="' + $(this).attr(labels.match) + '"]');
				var errorForMatch = null;
				
				if (val != matchField.val() && matchField.is(':visible:enabled')) {
					msg = $(this).attr(labels.matchMessage);
					errorForMatch = $(matchField).attr(labels.matchMessage);
				}
				addError(matchField, errorForMatch);
			}
			
			addError(this, msg);
		},
		autoValidateForm: function () {
			if (!_.isUndefined($(this).attr(labels.autoValidate))) return;
			$(this).attr(labels.autoValidate, 'true').attr('novalidate', 'true');
			$(this).find('input').change(UF.business.Form.validate).keyup(UF.business.Form.validate);
			$(this).find('select').change(UF.business.Form.validate);
			$(this).submit(function () {
				$(this).find('select:visible').each(UF.business.Form.validate);
				$(this).find('input:visible').each(UF.business.Form.validate);
				var stack = [];
				$(this).find('.invalid').each(function (index) {
					stack.push((index+1) + '. ' + $(this).attr('title'));
				});
				
				if (stack.length == 0) {
					$(this).find('input[type="submit"]').prop('disabled', false);
					return true;
				}
				
				alert('以下项目需要修正：\n' + stack.join('\n'));
				return false;
			});
		},
		renderModel: function (model) {
			function getValue(name) {
				return model.hasOwnProperty(name) ? model[name] : '';
			}
			
			function getValueEx(name) {
		    	var stack = name.split('+');
		    	for (var i = 0; i < stack.length; i++) {
		    		var n = stack[i];
		    		var v = getValue(n);
		    		if (UF.base.Renderers.hasOwnProperty(n)) {
		    			var renderer = UF.base.Renderers[n];
		    			if (_.isFunction(renderer)) {
		    				v = renderer(v, model);
		    			}
		    			else if (_.isObject(renderer) || _.isArray(renderer)) {
		    				v = renderer[v];
		    			}
		    		}
		    		stack[i] = v;
		    	}
		    	
		    	return stack.join('');
			}
			
		    $('*[name]').each(function () {
		    	var name = $(this).attr('name');
		    	
		        switch ($(this).prop('tagName').toLowerCase()) {
			        case 'input':
			        	switch ($(this).attr('type')) {
			        	case 'radio':
			                $(this).prop('checked', $(this).val() == getValue(name));
			                break;
			        	case 'checkbox':
			        		$(this).prop('checked', getValue(name));
			        		break;
			            default:
			                $(this).val(getValue(name));
			            }
			        	if ($(this).is(':visible')) UF.business.Form.validate.call(this);
			            break;
			        case 'select':
		                $(this).val(getValue(name));
			        	if ($(this).is(':visible')) UF.business.Form.validate.call(this);
			        	break;
			        case 'span':
			        case 'div':
			            this.innerHTML = getValueEx(name);
			            break;
			        case 'img':
			        	$(this).attr('src', getValue(name));
		        }
		    });
		}
	}
})();