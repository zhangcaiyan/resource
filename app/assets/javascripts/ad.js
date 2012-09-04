/*搜索*/
							function g(o){return document.getElementById(o);}
									function HoverLi(n,m,q,p){
									for(var i=1;i<=m;i++)
									{
									g(q +i).className='';
									g(p+i).className='undis';
									}
									g(p+n).className='input_bot';
									g(q+n).className='on';
									}
									
