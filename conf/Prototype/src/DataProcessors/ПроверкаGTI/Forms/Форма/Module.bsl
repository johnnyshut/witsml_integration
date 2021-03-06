///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО Фобизнес ПРО
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by-sa/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

// Процедура - Обработчик события "ПриОткрытии" формы
//
// Параметры:
//  Отказ	 - Булево - Отказ 
//
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	СкрытьПараметрыИСтраницыМетода();
	Элементы.ФормаИзменитьРежим.Пометка = Ложь;
	
КонецПроцедуры

// Процедура - Обработчик команды "Изменить режим"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "Изменить режим" 
//
&НаКлиенте
Процедура ИзменитьРежим(Команда)
	
	Режим = ?(Режим = 0, 1, 0);
	СкрытьПараметрыИСтраницыМетода();
	
	Элементы.ФормаИзменитьРежим.Пометка = ?(Режим = 0, Ложь, Истина);
	
КонецПроцедуры

// Процедура - Обработчик команды "Инициализация"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "Инициализация"
//
&НаКлиенте
Процедура Инициализация(Команда)
	
	ВыполнитьМетод_ПоКоманде();
	
КонецПроцедуры

// Процедура - Обработчик команды "Выполнить"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "Выполнить" 
//
&НаКлиенте
Процедура ВыполнитьЗапрос(Команда)
	
	ВыполнитьМетод_ПоКоманде();
	
КонецПроцедуры

// Процедура - Получить шаблон запроса скважин
// Заполняет на странице "Настройка", реквизит "QueryIn" и "WMLTypeIn" 
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "ПолучитьШаблон_ЗапросСкважин"
//
&НаКлиенте
Процедура ПолучитьШаблон_ЗапросСкважин(Команда)
	
	ПолучитьШаблонЗапроса_ПоКоманде("WMLS_GetFromStore", "well");
	
КонецПроцедуры

// Процедура - Получить шаблон запроса стволов
// Заполняет на странице "Настройка", реквизит "QueryIn" и "WMLTypeIn" 
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "ПолучитьШаблон_ЗапросСтволов"
//
&НаКлиенте
Процедура ПолучитьШаблон_ЗапросСтволов(Команда)
	
	ПолучитьШаблонЗапроса_ПоКоманде("WMLS_GetFromStore", "wellbore");
	
КонецПроцедуры

// Процедура - Получить шаблон запрос операции
// Заполняет на странице "Настройка", реквизит "QueryIn" и "WMLTypeIn"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "ПолучитьШаблон_ЗапросОперации"
//
&НаКлиенте
Процедура ПолучитьШаблон_ЗапросОперации(Команда)
	
	ПолучитьШаблонЗапроса_ПоКоманде("WMLS_GetFromStore", "log");
	
КонецПроцедуры

// Процедура - Получить шаблон запрос доступные мнемоники
// Заполняет на странице "WMLS_GetFromStore - Операции", реквизит "Отбор_indexCurve" и "Отбор_uidLogCurveInfo"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "ПолучитьШаблон_ЗапросДоступныеМнемоники"
//
&НаКлиенте
Процедура ПолучитьШаблон_ЗапросДоступныеМнемоники(Команда)
	
	ПолучитьШаблонЗапроса_ПоКоманде("WMLS_GetFromStore", "log_Mnemoniki");	 	
	
КонецПроцедуры

// Процедура - Получить шаблон запрос данных журнала
// Заполняет на странице "Настройка", реквизит "QueryIn" и "WMLTypeIn"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "ПолучитьШаблон_ЗапросДанныеЖурнала"
//
&НаКлиенте
Процедура ПолучитьШаблон_ЗапросДанныеЖурнала(Команда)
	
	ПолучитьШаблонЗапроса_ПоКоманде("WMLS_GetFromStore", "log_Data");
	
КонецПроцедуры

// Процедура - Обработчик события "ПриИзменении" реквизита формы "Метод"
//
// Параметры:
//  Элемент	 - ПолеФормы - Реквизит "Метод"
//
&НаКлиенте
Процедура МетодПриИзменении(Элемент)
	
	СкрытьПараметрыИСтраницыМетода();
	ОчиститьРезультатыНаФорме();
	ДобавитьРеквизитыПараметровМетодаНаФорму_НаСервере(Элемент.ВыделенныйТекст);	
	
КонецПроцедуры

// Процедура - Обработчик события "ПриАктивизацииСтроки" таблицы "wells"
//
// Параметры:
//  Элемент	 - Булево - Отказ 
//
&НаКлиенте
Процедура wellsПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ОбработкаОжидания_ПриАктивизацииСтроки_wells", 0.1, Истина);
	
КонецПроцедуры

// Процедура - Обработчик события "ПриАктивизацииСтроки" таблицы "wellbores"
//
// Параметры:
//  Элемент	 - Булево - Отказ 
//
&НаКлиенте
Процедура wellboresПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ОбработкаОжидания_ПриАктивизацииСтроки_wellbores", 0.1, Истина);	
	
КонецПроцедуры

// Процедура - Обработчик события "ПриАктивизацииСтроки" таблицы "logs"
//
// Параметры:
//  Элемент	 - Булево - Отказ 
//
&НаКлиенте
Процедура logsПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ОбработкаОжидания_ПриАктивизацииСтроки_logs", 0.1, Истина);
	
КонецПроцедуры

// Процедура - Обработчик команды "login"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "login" 
//
&НаКлиенте
Процедура Режим1_Login(Команда)
	
	ВыполнитьHTTPЗапрос("Login", "/index.html");		
	
КонецПроцедуры

// Процедура - Обработчик команды "getparaminfo"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "getparaminfo" 
//
&НаКлиенте
Процедура Режим1_Getparaminfo(Команда)
	
	ВыполнитьHTTPЗапрос("Getparaminfo", "/getparaminfo");
	
КонецПроцедуры

// Процедура - Обработчик команды "getwellbore"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "getwellbore" 
//
&НаКлиенте
Процедура Режим1_Getwellbore(Команда)
	
	ВыполнитьHTTPЗапрос("Getwellbore", "/WMLS/wellbore.php");
	
КонецПроцедуры

// Процедура - Обработчик команды "getopslog"
//
// Параметры:
//  Команда	 - КомандаФормы - Команда формы "getopslog" 
//
&НаКлиенте
Процедура Режим1_Getopslog(Команда)
	
	ВыполнитьHTTPЗапрос("Getopslog", "/getopslog");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедура - Выполнение метода
// При выполнении сценарий исполнения определяется структурой доступных методов полученных при инициализации (WMLS_GetCap) или от выбранного значения в реквизите "Метод"
//
&НаКлиенте
Процедура ВыполнитьМетод_ПоКоманде()
	
	ПараметрыМетода = ИнициализироватьОбязательнуюСтруктуруМетода();
	ДобавитьПараметрыМетода(ПараметрыМетода);
	
	Результат = РаботаСGTIOnlineВызовСервера.ВыполнитьМетод(ПараметрыМетода);
	Результат.Вставить("АльтернативнаяТаблицаДляВыводаНаФорму", АльтернативнаяТаблицаДляВыводаНаФорму);
	
	Если Результат.Успешно = 0 Тогда 
		
		Элементы.ГруппаОсновная.Доступность = Ложь;
		
		Метод = "WMLS_GetCap";
		
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = НСтр("ru = 'Не предсказуемая ошибка работы с GTIONLINE'"
		+ "; en = 'Unpredictable error with GTIONLINE'");
		Сообщение.Сообщить();
		
	ИначеЕсли Результат.Успешно = 1 Тогда  
		
		Элементы.ГруппаОсновная.Доступность = Истина;	
		
		РаботаСGTIOnlineВызовСервера.ПрочитатьРезультат(Результат);
		
	ИначеЕсли Результат.Успешно = "Function completed successfully" Тогда 	
		
		Элементы.ГруппаОсновная.Доступность = Истина;
		
	КонецЕсли;
	
	ВывестиРезультатВыполненияМетодаНаФорму(Результат); 
	
	Если Метод = "WMLS_GetCap" И Результат.Свойство("таблицаСвойстваWSDL") Тогда 			
		ВывестиДоступныеМетодыНаФорму(Результат);		
	КонецЕсли;	
	
КонецПроцедуры	

// Функция - Инициализировать обязательную структуру метода
// 
// Возвращаемое значение:
//  Структура - Параметры метода
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Логин     - Строка - Данные авторизации.
//    * Пароль    - Строка - Данные авторизации.
//
&НаКлиенте
Функция ИнициализироватьОбязательнуюСтруктуруМетода()
	
	ПараметрыМетода = Новый Структура("ИмяМетода, Логин, Пароль", Метод, Логин, Пароль);
	Возврат ПараметрыМетода;
	
КонецФункции

// Процедура - Скрыть все параметры и страницы относящиеся к методу
// Для каждого метода собственные наборы свойств и страницы с данными, сначала все их скроем
//
&НаКлиенте
Процедура СкрытьПараметрыИСтраницыМетода()
	
	Элементы.СтраницыОсновные.Видимость 	   = Ложь;
	Элементы.СтраницыРежим1.Видимость 		   = Ложь;
	Элементы.ФормаИнициализация.Видимость 	   = Ложь;
	Элементы.ФормаИнициализация_Альт.Видимость = Ложь;

	Если Режим = 0 Тогда 
		               
		Элементы.СтраницыОсновные.Видимость   = Истина;
		Элементы.ФормаИнициализация.Видимость = Истина;
		
		Для Каждого ЭлементФормы Из Элементы.ГруппаПараметрыМетода.ПодчиненныеЭлементы Цикл 
			ЭлементФормы.Видимость = Ложь;
		КонецЦикла;
		
		Для Каждого СтраницаФормы Из Элементы.СтраницыОсновные.ПодчиненныеЭлементы Цикл 
			Если СтраницаФормы <> Элементы.Страница_Настройки Тогда 
				СтраницаФормы.Видимость = Ложь;	
			КонецЕсли;			
		КонецЦикла;	
		
	ИначеЕсли Режим = 1 Тогда 
		
		Элементы.СтраницыРежим1.Видимость 		   = Истина;
		Элементы.ФормаИнициализация_Альт.Видимость = Истина;

	КонецЕсли;

КонецПроцедуры

// Процедура - Очистить результаты на форме
//
&НаКлиенте
Процедура ОчиститьРезультатыНаФорме()
	
	РезультатЗапроса = "";
	Ошибка 			 = "";
	АльтернативнаяТаблицаДляВыводаНаФорму = "";
		
КонецПроцедуры

// Процедура - Добавить реквизиты параметров метода на форму
// В зависимости от метода определяется свой список свойств и страниц на форме, общий список определяется в общем модуле "РаботаСGTIOnlineПовтИсп"
//
// Параметры:
//  ИмяМетода	 - Строка - Выбранный метод на форме
//
&НаСервере
Процедура ДобавитьРеквизитыПараметровМетодаНаФорму_НаСервере(ИмяМетода)
	
	тзНастройкиДоступныхПолейМетодов = РаботаСGTIOnlineВызовСервераПовтИсп.ОпределитьНастройкиМетодов();
	СтрокиНастройки = тзНастройкиДоступныхПолейМетодов.НайтиСтроки(Новый Структура("Метод", ИмяМетода));
	Для Каждого СтрокаНастройки Из СтрокиНастройки Цикл 
		Если СтрокаНастройки.ЭтоИсходящееСвойство Тогда 	
			
			Элементы[СтрокаНастройки.ДоступноеПоле].Видимость = Истина;
			
		КонецЕсли;		
	КонецЦикла;	
	
	НайденнаяСтраницаМетода = Элементы.Найти("Страница_" + ИмяМетода);
	Если НайденнаяСтраницаМетода <> Неопределено Тогда 
		НайденнаяСтраницаМетода.Видимость = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Процедура - Добавить параметры метода с формы
// Параметры определяются в общем модуля "РаботаСGTIOnlineПовтИсп" для каждого метода
//
// Параметры:
//  ПараметрыМетода	 - Структура - Параметры метода
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Логин     - Строка - Данные авторизации.
//    * Пароль    - Строка - Данные авторизации.
//
&НаКлиенте
Процедура ДобавитьПараметрыМетода(ПараметрыМетода)
	
	Для Каждого ЭлементФормы Из Элементы.ГруппаПараметрыМетода.ПодчиненныеЭлементы Цикл 
		Если ЭлементФормы.Видимость Тогда 
			ПараметрыМетода.Вставить(ЭлементФормы.Имя, ЭлементФормы.ТекстРедактирования);
		КонецЕсли;	
	КонецЦикла;		
	
КонецПроцедуры	

// Процедура - Вывести результат выполнения метода на форму
//
// Параметры:
//  Результат	 - Структура - Параметры работы с сервисом: 
//    * ИмяМетода 			- Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   			- Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//    * ПутьКФайлу		    - Строка - В предыдущей процедуре ответ в виде XML строки записывается во временный файл, который здесь будем прочитан. 
//    * Остальные свойства формируются динамически, в зависимости от метода. Общий модуль "РаботаСGTIOnlineПовтИсп" определяет набор свойств и возможных доступных методов 
//
&НаКлиенте
Процедура ВывестиРезультатВыполненияМетодаНаФорму(Результат)
	
	ИмяТаблицыВывода = ?(ПустаяСтрока(АльтернативнаяТаблицаДляВыводаНаФорму), "", АльтернативнаяТаблицаДляВыводаНаФорму);
	
	ОчиститьРезультатыНаФорме();
	
	Если Метод = "WMLS_GetVersion" Или Метод = "WMLS_GetBaseMsg" Тогда 
		РезультатЗапроса = Результат.Успешно;	
		
	Иначе 	
		
		Если Результат.Свойство("СтрокаXMLОтвета") Тогда 
			Результат.Свойство(Результат.СтрокаXMLОтвета, РезультатЗапроса);	
		КонецЕсли;	
		
		Если Результат.Свойство("СтрокаПоляОшибки") Тогда 
			Результат.Свойство(Результат.СтрокаПоляОшибки, Ошибка);
		КонецЕсли;
				
	КонецЕсли;
	
	Если Результат.Свойство("Структура_ОбработанныйОтветОтСервиса") Тогда 
		
		Если Результат.Структура_ОбработанныйОтветОтСервиса.Свойство("Заголовок") Тогда 	
			
			Если ПустаяСтрока(ИмяТаблицыВывода) Тогда 
				ИмяТаблицы = Результат.Структура_ОбработанныйОтветОтСервиса.Заголовок;
			Иначе 
				ИмяТаблицы = ИмяТаблицыВывода;
			КонецЕсли;
			
			КоллекцияЗначенийНаФорме = ЭтаФорма[ИмяТаблицы];
			КоллекцияЗначенийНаФорме.Очистить();
						
			Для Каждого СтрокаОтветаОтСервиса Из Результат.Структура_ОбработанныйОтветОтСервиса.МассивСодержание Цикл 
				НоваяСтрока = КоллекцияЗначенийНаФорме.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаОтветаОтСервиса);	
			КонецЦикла;	
			
		Иначе 
			Сообщение = Новый СообщениеПользователю();
			Сообщение.Текст = НСтр("ru = 'Не найден заголовок ответа от сервиса GTI-Online'");
			Сообщение.Сообщить();
			
		КонецЕсли;		
		
		Элементы.СтраницыОсновные.ТекущаяСтраница = Элементы["Страница_" + Результат.ИмяМетода];
				
	КонецЕсли;
	
	log_Mnemoniki.Сортировать("uid");
	Элементы.Отбор_uidLogCurveInfo.СписокВыбора.Очистить();
	Для Каждого Мнемоник Из log_Mnemoniki Цикл 	
		Элементы.Отбор_uidLogCurveInfo.СписокВыбора.Добавить(Мнемоник.uid);
	КонецЦикла;
	
КонецПроцедуры

// Процедура - Вывести доступные методы на форму
// Доступные методы определяются сначала по общей таблице из общего модуля "РаботаСGTIOnlineПовтИсп" и далее по доступности методов на сервисе
//
// Параметры:
//  Результат	 - Структура - Параметры работы с сервисом: 
//    * ИмяМетода 			- Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   			- Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//    * ПутьКФайлу		    - Строка - В предыдущей процедуре ответ в виде XML строки записывается во временный файл, который здесь будем прочитан. 
//    * Остальные свойства формируются динамически, в зависимости от метода. Общий модуль "РаботаСGTIOnlineПовтИсп" определяет набор свойств и возможных доступных методов
//
&НаКлиенте
Процедура ВывестиДоступныеМетодыНаФорму(Результат)
	
	Элементы.Метод.СписокВыбора.Очистить();
	Элементы.WMLtypeIn.СписокВыбора.Очистить();
	
	ПредыдущаяФункция = Неопределено;
	Для Каждого Свойство Из Результат.таблицаСвойстваWSDL Цикл 
		
		Если Свойство.Функция = "WMLS_GetFromStore" Тогда	
			Элементы.WMLtypeIn.СписокВыбора.Добавить(Свойство.ОбъектДанных);
		КонецЕсли;
		
		Если ПредыдущаяФункция <> Свойство.Функция Тогда 
			Элементы.Метод.СписокВыбора.Добавить(Свойство.Функция);
			ПредыдущаяФункция = Свойство.Функция;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры	

// Процедура - Получить шаблон запроса по команде
//
// Параметры:
//  ИмяМетода			 - Строка - Предопределенное значение WMLS_GetFromStore 
//  Значение_WMLtypeIn	 - Строка - Предопределенное значение well или wellbore
//
&НаКлиенте
Процедура ПолучитьШаблонЗапроса_ПоКоманде(Знач ИмяМетода, Знач Значение_WMLtypeIn)
	
	// TODO Сделать через перебор
	СтруктураПолученияЗапроса = Новый Структура("Значение_WMLtypeIn", Значение_WMLtypeIn);
	СтруктураПолученияЗапроса.Вставить("uidLog", Отбор_uidLog);
	СтруктураПолученияЗапроса.Вставить("uidWell", Отбор_uidWell);
	СтруктураПолученияЗапроса.Вставить("uidWellbore", Отбор_uidWellbore);
	СтруктураПолученияЗапроса.Вставить("indexType", Отбор_indexType);
	СтруктураПолученияЗапроса.Вставить("indexCurve", Отбор_indexCurve);
	СтруктураПолученияЗапроса.Вставить("startDateTimeIndex", Отбор_startDateTimeIndex);
	СтруктураПолученияЗапроса.Вставить("endDateTimeIndex", Отбор_endDateTimeIndex);
	СтруктураПолученияЗапроса.Вставить("uidLogCurveInfo", Отбор_uidLogCurveInfo);
	
	СтруктураОтвета = РаботаСGTIOnlineВызовСервера.ОпределитьНастройкиЗапросаКМетоду_ПоШаблону(СтруктураПолученияЗапроса);		
	ЗаполнитьЗначенияСвойств(ЭтаФорма, СтруктураОтвета);	
	Элементы.СтраницыОсновные.ТекущаяСтраница = Элементы.Страница_Настройки;
	
КонецПроцедуры

// Процедура - Обработка ожидания "ПриАктивизацииСтроки" таблицы "wells"
//
&НаКлиенте
Процедура ОбработкаОжидания_ПриАктивизацииСтроки_wells() Экспорт 
	
	// TODO Сделать один обработчик, для всех активаций строки

	Если Элементы.wells.ТекущиеДанные <> Неопределено Тогда 
		Отбор_uidWell = Элементы.wells.ТекущиеДанные.uid;
	КонецЕсли;
	
КонецПроцедуры 

// Процедура - Обработка ожидания "ПриАктивизацииСтроки" таблицы "wellbores"
//
&НаКлиенте
Процедура ОбработкаОжидания_ПриАктивизацииСтроки_wellbores() Экспорт
	
	// TODO Сделать один обработчик, для всех активаций строки
	
	Если Элементы.wellbores.ТекущиеДанные <> Неопределено Тогда
		Отбор_uidWellbore = Элементы.wellbores.ТекущиеДанные.uid;
	КонецЕсли;
	
КонецПроцедуры 

// Процедура - Обработка ожидания "ПриАктивизацииСтроки" таблицы "logs"
//
&НаКлиенте
Процедура ОбработкаОжидания_ПриАктивизацииСтроки_logs() Экспорт 

	// TODO Сделать один обработчик, для всех активаций строки
	
	Если Элементы.logs.ТекущиеДанные <> Неопределено Тогда
		Отбор_uidLog 			 = Элементы.logs.ТекущиеДанные.uid;
		Отбор_startDateTimeIndex = Элементы.logs.ТекущиеДанные.startDateTimeIndex;
		Отбор_endDateTimeIndex 	 = Элементы.logs.ТекущиеДанные.endDateTimeIndex;
		Отбор_indexType 		 = Элементы.logs.ТекущиеДанные.indexType;
		Отбор_indexCurve 		 = Элементы.logs.ТекущиеДанные.indexCurve;  
		Отбор_uidLogCurveInfo 	 = "";
	КонецЕсли;
	
КонецПроцедуры 

// Процедура - Выполнить HTTP запрос к веб сервису
//
// Параметры:
//  Режим1_Метод	 - Строка - Метод вызываемый на клиенте
//  ПутьНаСервере	 - Строка - Адрес сервиса в интернете, "http..."
//
&НаКлиенте
Процедура ВыполнитьHTTPЗапрос(Режим1_Метод, ПутьНаСервере)
	
	СтруктураURI = РаботаСGTIOnlineВызовСервера.СтруктураURI(Режим1_ПолныйАдресРесурса); 
	HTTPСоединение = Новый HTTPСоединение(СтруктураURI.Хост, СтруктураURI.Порт,,,,10); 
	HTTPЗапрос = Новый HTTPЗапрос(ПутьНаСервере);
	
	HTTPЗапрос.Заголовки.Вставить("Content-Type", "application/x-www-form-urlencoded");	
	HTTPЗапрос.Заголовки.Вставить("cache-control", "no-cache");
	
	Если Режим1_Метод = "Login" Тогда 	
		HTTPЗапрос.АдресРесурса = HTTPЗапрос.АдресРесурса + "?force=true";	
		HTTPЗапрос.УстановитьТелоИзСтроки("user=" + Логин + "&pwd=" + Пароль);
		
	ИначеЕсли Режим1_Метод = "Getparaminfo" Тогда	
		HTTPЗапрос.УстановитьТелоИзСтроки("s=" + Режим1_SID);
		
	ИначеЕсли Режим1_Метод = "Getwellbore" Тогда		
		HTTPЗапрос.УстановитьТелоИзСтроки("s=" + Режим1_SID + "&wml=" + РаботаСGTIOnlineВызовСервера.Получить_wml_Значение(Режим1_uidWell) + "&session=" + Режим1_Session);
		
	ИначеЕсли Режим1_Метод = "Getopslog" Тогда		
		HTTPЗапрос.УстановитьТелоИзСтроки("s=" + Режим1_SID + "&force=" + "true" + "&w=" + Режим1_uidWell + "&m=" + Режим1_month + "&y=" + Режим1_year);
		
	КонецЕсли;	
	 	
	Попытка
		Результат = HTTPСоединение.ОтправитьДляОбработки(HTTPЗапрос);
	Исключение
		Сообщить("Произошла сетевая ошибка!");
		ВызватьИсключение;
	КонецПопытки;
		
	ПроверитьКодСостояния(Результат.КодСостояния); 
	Режим1_КодСостояния  = Результат.КодСостояния;
	Режим1_HTTP_Response = Результат.ПолучитьТелоКакСтроку();
	
	Если Результат.КодСостояния = 200 Тогда 
		
		ЧтениеHTML = Новый ЧтениеHTML();
		ЧтениеHTML.ОткрытьПоток(Результат.ПолучитьТелоКакПоток(), "UTF-8");
		ПостроительDOM = Новый ПостроительDOM;
		ДокументHTML = ПостроительDOM.Прочитать(ЧтениеHTML);
		ЧтениеHTML.Закрыть();
		
		Если ДокументHTML.Тело <> Неопределено Тогда
			
			Обход = ДокументHTML.СоздатьОбходДерева(ДокументHTML.Тело);	
			Пока Обход.СледующийУзел() <> Неопределено Цикл 
				
				ТекущийУзел = Обход.ТекущийУзел;
				
				Если Режим1_Метод = "Login" Тогда 
					
					Если ТекущийУзел.ИмяУзла = "object" Тогда 	
						Если ТекущийУзел.Идентификатор = "frontend" Тогда 							
							Для Каждого ДочернийУзел Из ТекущийУзел.ДочерниеУзлы Цикл 								
								Если ДочернийУзел.ТипУзла = ТипУзлаDOM.Элемент 
									И ДочернийУзел.ИмяУзла = "param" 
									И ДочернийУзел.ЕстьАтрибуты() Тогда 
										АтрибутName = ДочернийУзел.Атрибуты.ПолучитьИменованныйЭлемент("name");
										Если АтрибутName.Значение = "FlashVars" Тогда 
											 АтрибутValue = ДочернийУзел.Атрибуты.ПолучитьИменованныйЭлемент("value");	
											 Режим1_SID = СтрЗаменить(АтрибутValue.Значение,"SID=","");
										КонецЕсли;	
								КонецЕсли;								
							КонецЦикла;						
						КонецЕсли;						
					КонецЕсли;
					
 				ИначеЕсли Режим1_Метод = "Getparaminfo" Тогда	
					
					Если ТекущийУзел.ИмяУзла = "response" Тогда
						ТекстовоеСодержимое = ТекущийУзел.ТекстовоеСодержимое;
						ТекстовоеСодержимое = СтрЗаменить(ТекстовоеСодержимое, "WMLS", "");
						Режим1_Session      = СтрЗаменить(ТекстовоеСодержимое, "false", "");	
					КонецЕсли;
					
				ИначеЕсли Режим1_Метод = "Getwellbore" Тогда		
					
					Если ТекущийУзел.ИмяУзла = "wellbores" Тогда
						Режим1_Getwellbore.Очистить();
						Для Каждого ДочернийУзел Из ТекущийУзел.ДочерниеУзлы Цикл 
							Если ДочернийУзел.ТипУзла = ТипУзлаDOM.Элемент 
									И ДочернийУзел.ИмяУзла = "wellbore" 
									И ДочернийУзел.ЕстьАтрибуты() Тогда	
									ЗаписьВТаблицу      = Режим1_Getwellbore.Добавить();
									Атрибут_uidwell     = ДочернийУзел.Атрибуты.ПолучитьИменованныйЭлемент("uidwell");
									Атрибут_uidwellbore = ДочернийУзел.Атрибуты.ПолучитьИменованныйЭлемент("uidwellbore");
									Для Каждого ДочернийПодУзел Из ДочернийУзел.ДочерниеУзлы Цикл 	
										ЗаписьВТаблицу.uidWell     = Атрибут_uidwell.Значение;
										ЗаписьВТаблицу.uidWellbore = Атрибут_uidwellbore.Значение;
										Если ДочернийПодУзел.ИмяУзла = "namewellbore" Тогда 
											ЗаписьВТаблицу.nameWellbore   = ДочернийПодУзел.ТекстовоеСодержимое;	
										КонецЕсли;
										Если ДочернийПодУзел.ИмяУзла = "namewell" Тогда 
											ЗаписьВТаблицу.nameWell       = ДочернийПодУзел.ТекстовоеСодержимое;	
										КонецЕсли;
										Если ДочернийПодУзел.ИмяУзла = "dtimlastchange" Тогда
											ЗаписьВТаблицу.dTimLastChange = ДочернийПодУзел.ТекстовоеСодержимое;
										КонецЕсли;
										Если ДочернийПодУзел.ИмяУзла = "dtimcreation" Тогда
											ЗаписьВТаблицу.dTimCreation   = ДочернийПодУзел.ТекстовоеСодержимое;
										КонецЕсли;										
									КонецЦикла;
							КонецЕсли;
						КонецЦикла;	
					КонецЕсли;
					
				ИначеЕсли Режим1_Метод = "Getopslog" Тогда		
					
					Если ТекущийУзел.ИмяУзла = "opslog" Тогда
						Режим1_Opslog.Очистить();
						Атрибут_w = ТекущийУзел.Атрибуты.ПолучитьИменованныйЭлемент("w");
						Для Каждого ДочернийУзел Из ТекущийУзел.ДочерниеУзлы Цикл 
							Если ДочернийУзел.ТипУзла = ТипУзлаDOM.Элемент 
									И ДочернийУзел.ИмяУзла = "log" 
									И ДочернийУзел.ЕстьАтрибуты() Тогда
									Атрибут_y      = ДочернийУзел.Атрибуты.ПолучитьИменованныйЭлемент("y");
									Атрибут_m      = ДочернийУзел.Атрибуты.ПолучитьИменованныйЭлемент("m");
									Для Каждого ДочернийПодУзел Из ДочернийУзел.ДочерниеУзлы Цикл 
										ЗаписьВТаблицу = Режим1_Opslog.Добавить();
										ЗаписьВТаблицу.w	   = Атрибут_w.Значение;
										ЗаписьВТаблицу.y       = Атрибут_y.Значение;
										ЗаписьВТаблицу.m       = Атрибут_m.Значение;
										ЗаписьВТаблицу.oper_id = ДочернийПодУзел.Атрибуты.ПолучитьИменованныйЭлемент("id").Значение;
										ЗаписьВТаблицу.date    = ДочернийПодУзел.Атрибуты.ПолучитьИменованныйЭлемент("date").Значение;
									    ЗаписьВТаблицу.dur     = ДочернийПодУзел.Атрибуты.ПолучитьИменованныйЭлемент("dur").Значение;
										ЗаписьВТаблицу.trip    = ДочернийПодУзел.Атрибуты.ПолучитьИменованныйЭлемент("trip").Значение;
										ЗаписьВТаблицу.depth   = ДочернийПодУзел.Атрибуты.ПолучитьИменованныйЭлемент("depth").Значение;
										ЗаписьВТаблицу.op_str  = ДочернийПодУзел.Атрибуты.ПолучитьИменованныйЭлемент("op_str").Значение;
										Для Каждого КомментарийКОперации Из ДочернийПодУзел.ДочерниеУзлы Цикл
											Если КомментарийКОперации.ИмяУзла = "#text" Тогда 
												ЗаписьВТаблицу.oper = КомментарийКОперации.ТекстовоеСодержимое;					
											КонецЕсли;
										КонецЦикла;
									КонецЦикла;
							КонецЕсли;
						КонецЦикла;
					КонецЕсли;	
					
				КонецЕсли;
	
			КонецЦикла;	
			
		Иначе 
			
			Сообщить("Не найдено тело документа");
				
		КонецЕсли;	
		
	КонецЕсли;	
	
КонецПроцедуры

// Процедура - Проверить код состояния ответа от веб сервиса
//
// Параметры:
//  КодСостояния - Строка - Коды ответа от веб сервиса
//
&НаКлиенте
Процедура ПроверитьКодСостояния(КодСостояния)

	Если КодСостояния >= 400 и КодСостояния < 500  Тогда
		Сообщить("Код статуса больше 4XX, ошибка запроса.  Код статуса: " + КодСостояния);
	КонецЕсли;
	
	Если КодСостояния >= 500 и КодСостояния < 600  Тогда
		Сообщить("Код статуса больше 5XX, ошибка сервера. Код статуса: " + КодСостояния);
	КонецЕсли;
	
	Если КодСостояния >= 300 и КодСостояния < 400  Тогда
		Сообщить("Код статуса больше 3XX, Перенаправление. Код статуса: " + КодСостояния);
		Если КодСостояния = 302 Тогда
			Сообщить("Код статуса 302, Постоянное перенаправление.");
		КонецЕсли;
	КонецЕсли;
	
	Если КодСостояния < 300 и КодСостояния <> 200 Тогда
		Сообщить("Сервер успешно ответил, но это не код 200");
		Сообщить("Код статуса: " + КодСостояния);		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Инициализация

Если ПустаяСтрока(Метод) Тогда 
	Метод = "WMLS_GetCap";
КонецЕсли;	

#КонецОбласти