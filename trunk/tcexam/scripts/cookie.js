/*设定cookie*/
function setCookie(name, value)
{
	var today = new Date();
	var expires = new Date();
	expires.setTime(today.getTime()+3600*24*365);
	document.cookie = name + "=" + escape(value) + "; expires=" + expires.toGMTString();
}
function setTemporaryCookie(name, value)
{
	var today = new Date();
	var expires = new Date();
	expires.setTime(today.getTime()+0);
	document.cookie = name + "=" + escape(value) + "; expires=" + expires.toGMTString();
}
/*获取cookie*/
function getCookie(Name) 
{
	var search = Name + "=";
	if (document.cookie.length > 0)
	{
		offset = document.cookie.indexOf(search);
		if (offset != -1)
		{
			offset += search.length;
			end = document.cookie.indexOf(";", offset);
			if (end == -1) 
			{
				end = document.cookie.length;
			}
			try
			{
				return unescape(decodeURI(document.cookie.substring(offset, end)));
			}
			catch (err)
			{
				try
				{
					return unescape(document.cookie.substring(offset, end));
				}
				catch (err)
				{
					return document.cookie.substring(offset, end);
				}
			}

		}
		else
		{
			return ("");
		}
	}
	else
	{
		return ("");
	}
}