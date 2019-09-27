///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО Фобизнес ПРО
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Функция - Выполнение выбранного метода на сервисе GTI-Online
//
// Параметры:
//  ПараметрыМетода	 - Структура - Параметры метода
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Логин     - Строка - Данные авторизации.
//    * Пароль    - Строка - Данные авторизации.
// 
// Возвращаемое значение:
//  Структура - Параметры работы с сервисом:
//    * Успешно   - Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//    * ИмяМетода - Строка - Имя метода, который требуется выполнить (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Остальные свойства формируются динамически, в зависимости от метода. Общий модуль "РаботаСGTIOnlineПовтИсп" определяет набор свойств и возможных доступных методов 
//
Функция ВыполнитьМетод(ПараметрыМетода) Экспорт 
	
	ИмяМетода = ПараметрыМетода.ИмяМетода;
	
	тзНастройкиДоступныхПолейМетодов = РаботаСGTIOnlineПовтИсп.ОпределитьНастройкиМетодов();
		
	Сервис = WSССылки.GTIONLINE.ПолучитьWSОпределения().Сервисы.Получить(0);
	Прокси = WSССылки.GTIONLINE.СоздатьWSПрокси(Сервис.URIПространстваИмен, Сервис.Имя, Сервис.ТочкиПодключения[0].Имя);
	Прокси.Пользователь = ПараметрыМетода.Логин;
	Прокси.Пароль 		= ПараметрыМетода.Пароль;
	
	Результат = ИнициализироватьОбязательнуюСтруктуруРезультата(ИмяМетода);
	
	СтрокиНастроек = ПолучитьСтрокиНастроекМетодаПоИмени(Результат, тзНастройкиДоступныхПолейМетодов);
	
	ДобавитьВРезультатПараметрыМетода(Результат, ПараметрыМетода, СтрокиНастроек);
		
	ПолучитьОтвет(Результат, Прокси);
	
	Возврат Результат;
	
КонецФункции

// Процедура - Получить ответ от сервиса GTI-Online
//
// Параметры:
//  Прокси		 - WSПрокси  - WS ссылка сервиса GTI-Online
//  Результат	 - Структура - Параметры работы с сервисом: 
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   - Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//    * Остальные свойства формируются динамически, в зависимости от метода. Общий модуль "РаботаСGTIOnlineПовтИсп" определяет набор свойств и возможных доступных методов
//
Процедура ПолучитьОтвет(Результат, Прокси) Экспорт 
	
	Ответ = 0;
   		
	Попытка	
		УстановитьБезопасныйРежим(Истина);
		Выполнить("Ответ = Прокси." + Результат.ИмяМетода + "(" + Результат.СтрокаПараметрыМетоды + ");");	
		УстановитьБезопасныйРежим(Ложь);
	Исключение
		ЗаписьЖурналаРегистрации(НСтр("ru='Ошибка получение ответа от GTI-Online.'"), 
        УровеньЖурналаРегистрации.Ошибка,
        Метаданные.WSСсылки.GTIONLINE,
        ,
        ОписаниеОшибки());	
	КонецПопытки;
		
	Результат.Вставить("Успешно", Ответ);	

КонецПроцедуры

// Процедура - Прочитать результат ответа от сервиса GTI-Online
// Ответ в виде XML строки записывается во временный файл
//
// Параметры:
//  Результат	 - Структура - Параметры работы с сервисом: 
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   - Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//    * Остальные свойства формируются динамически, в зависимости от метода. Общий модуль "РаботаСGTIOnlineПовтИсп" определяет набор свойств и возможных доступных методов
//
Процедура ПрочитатьРезультат(Результат) Экспорт 

	ПутьКФайлу = ПолучитьИмяВременногоФайла("xml");
	ЗаписатьТекст = Новый ТекстовыйДокумент;
	ЗаписатьТекст.УстановитьТекст(Результат[Результат.СтрокаXMLОтвета]);
	ЗаписатьТекст.Записать(ПутьКФайлу, "UTF-8");
	
	Результат.Вставить("ПутьКФайлу", ПутьКФайлу);

	// TODO Разбор WMLS_GetFromStore
	Если Результат.ИмяМетода = "WMLS_GetCap" Тогда 
		WMLS_GetCap_РазобратьОтвет(Результат);
	
	ИначеЕсли Результат.ИмяМетода = "WMLS_GetFromStore" Тогда	
		WMLS_GetFromStore_РазобратьОтвет(Результат);
		
	КонецЕсли;
	
	УдалитьФайлы(ПутьКФайлу);
	
КонецПроцедуры	

// Процедура - Разбирает ответ в виде XML строки по правилам соответствующим методу WMLS_GetCap
//
// Параметры:
//  Результат - Структура - Параметры работы с сервисом: 
//    * ИмяМетода 			- Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   			- Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//    * ПутьКФайлу		    - Строка - В предыдущей процедуре ответ в виде XML строки записывается во временный файл, который здесь будем прочитан. 
//    * таблицаСвойстваWSDL - Массив - Считанные доступные методы сервиса.
//    * Остальные свойства формируются динамически, в зависимости от метода. Общий модуль "РаботаСGTIOnlineПовтИсп" определяет набор свойств и возможных доступных методов
//
Процедура WMLS_GetCap_РазобратьОтвет(Результат) Экспорт 
	
	ПрочитьXMLСтрокуСПомощьюПостроителя(Результат);
	
	Для Каждого Элемент1Ур Из Результат.Документ.ЭлементДокумента.ДочерниеУзлы Цикл
		Если Элемент1Ур.ИмяУзла = "capServer" Тогда
			
			Для Каждого Элемент2Ур Из Элемент1Ур.ДочерниеУзлы Цикл 
				Если Элемент2Ур.ИмяУзла = "function" Тогда 
					
					НаимФункция = Элемент2Ур.Атрибуты[0].ЗначениеУзла;
					
					Для Каждого Элемент3Ур Из Элемент2Ур.ДочерниеУзлы Цикл 
						
						Для Каждого Атрибуты Из Элемент3Ур.ДочерниеУзлы Цикл												
							
							СтрокаСвойств = Новый Структура("Функция, ОбъектДанных", НаимФункция, Атрибуты.ЗначениеУзла);
							Результат.таблицаСвойстваWSDL.Добавить(СтрокаСвойств);							
							
						КонецЦикла;
						
					КонецЦикла;
					
					Если Элемент2Ур.ДочерниеУзлы.Количество() = 0 Тогда 
						
						СтрокаСвойств = Новый Структура("Функция, ОбъектДанных", НаимФункция, "нет данных");
						Результат.таблицаСвойстваWSDL.Добавить(СтрокаСвойств);
						
					КонецЕсли;	
					
				КонецЕсли;
			КонецЦикла;
			
		КонецЕсли;
	КонецЦикла;
	
	Результат.Удалить("Документ");
	Результат.Вставить("таблицаСвойстваWSDL", Результат.таблицаСвойстваWSDL);
	
КонецПроцедуры

// Процедура - Разбирает ответ в виде XML строки по правилам соответствующим методу WMLS_GetFromStore
//
// Параметры:
//  Результат - Структура - Параметры работы с сервисом: 
//    * ИмяМетода 			- Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   			- Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//    * ПутьКФайлу		    - Строка - В предыдущей процедуре ответ в виде XML строки записывается во временный файл, который здесь будем прочитан. 
//    * таблицаСвойстваWSDL - Массив - Считанные доступные методы сервиса.
//    * Остальные свойства формируются динамически, в зависимости от метода. Общий модуль "РаботаСGTIOnlineПовтИсп" определяет набор свойств и возможных доступных методов
//
Процедура WMLS_GetFromStore_РазобратьОтвет(Результат) Экспорт 
	
	ПрочитьXMLСтрокуСПомощьюПостроителя(Результат);	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Функция - Инициализировать обязательную структуру результата
//
// Параметры:
//  ИмяМетода	 - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion). 
// 
// Возвращаемое значение:
//  Структура - Параметры работы с сервисом: 
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   - Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//
Функция ИнициализироватьОбязательнуюСтруктуруРезультата(Знач ИмяМетода)
	Возврат Новый Структура("Успешно, ИмяМетода", 0, ИмяМетода);
КонецФункции	

// Функция - Получить строки настроек метода по имени
// Из общего списка доступных методов и свойств отбираем только удовлетворяющие условия (Те, что имеют доступные поля и соответствуют имени выполняемого метода)
//
// Параметры:
//  тзНастройкиДоступныхПолейМетодов - ТаблицаЗначений - Получена из общего модуля "РаботаСGTIOnlineПовтИсп" и определяет набор свойств и возможных доступных методов
//  Результат						 - Структура - Параметры работы с сервисом: 
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   - Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола. 
// 
// Возвращаемое значение:
//  Массив - Массив строк таблицы значений, соответствующих условиям поиска. Замечание! Массив хранит ссылки на строки таблицы значений, то есть при изменении строки в таблице, значение в массиве тоже будет измененным. 
//
Функция ПолучитьСтрокиНастроекМетодаПоИмени(Результат, Знач тзНастройкиДоступныхПолейМетодов)
	Возврат тзНастройкиДоступныхПолейМетодов.НайтиСтроки(Новый Структура("Метод, ЕстьДоступПоля", Результат.ИмяМетода, Истина));
КонецФункции	

// Процедура - Добавить в результат параметры метода
// Для каждого метода сервиса собственный набор доступных параметров
//
// Параметры:
//  Результат		 - Структура - Параметры работы с сервисом: 
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   - Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//
//  ПараметрыМетода	 - Структура - Параметры метода
//    * ИмяМетода - Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Логин     - Строка - Данные авторизации.
//    * Пароль    - Строка - Данные авторизации.
//
//  СтрокиНастроек	 - Массив - Доступные свойства для выполняемого метода сервиса Результат.ИмяМетода
//
Процедура ДобавитьВРезультатПараметрыМетода(Результат, Знач ПараметрыМетода, Знач СтрокиНастроек)
	
	Префикс = "Результат.";
	МассивПараметров = Новый Массив;
	Для Каждого СтрокаНастроек Из СтрокиНастроек Цикл 
		МассивПараметров.Добавить(Префикс + СтрокаНастроек.ДоступноеПоле);	

		ЗначениеПарам = "";
		Если СтрокаНастроек.ЭтоИсходящееСвойство Тогда
			Если ПараметрыМетода.Свойство(СтрокаНастроек.ДоступноеПоле) Тогда
				ПараметрыМетода.Свойство(СтрокаНастроек.ДоступноеПоле, ЗначениеПарам);		
			КонецЕсли;		
				
		КонецЕсли;		
		
	    Результат.Вставить(СтрокаНастроек.ДоступноеПоле, ЗначениеПарам);
		
		Если СтрокаНастроек.ЭтоXMLОтвет Тогда 
			Результат.Вставить("СтрокаXMLОтвета", СтрокаНастроек.ДоступноеПоле);	
		КонецЕсли;	
		
		Если СтрокаНастроек.ЭтоОписаниеОшибки Тогда 
			Результат.Вставить("СтрокаПоляОшибки", СтрокаНастроек.ДоступноеПоле);	
		КонецЕсли;		
		
	КонецЦикла;	
	
	Результат.Вставить("СтрокаПараметрыМетоды", СтрСоединить(МассивПараметров, ","));
	
КонецПроцедуры	

// Процедура - Прочить XML строку с помощью построителя
//
// Параметры:
//  Результат - Структура - Параметры работы с сервисом: 
//    * ИмяМетода 			- Строка - Метод исполняемый сервисом (Всегда доступны: WMLS_GetCap и WMLS_GetVersion).
//    * Успешно   			- Число  - Если успешно тогда 1, если не успешно тогда 0, метод WMLS_GetVersion возвращает номер версии протокола.
//    * ПутьКФайлу		    - Строка - В предыдущей процедуре ответ в виде XML строки записывается во временный файл, который здесь будем прочитан. 
//    * таблицаСвойстваWSDL - Массив - Считанные доступные методы сервиса.
//    * Документ		    - ДокументDOM - Считанный файл с XMl ответа.
//    * Остальные свойства формируются динамически, в зависимости от метода. Общий модуль "РаботаСGTIOnlineПовтИсп" определяет набор свойств и возможных доступных методов
//
Процедура ПрочитьXMLСтрокуСПомощьюПостроителя(Результат)
	
	таблицаСвойстваWSDL = Новый Массив;
	таблицаСвойстваWSDL.Очистить();
	
	МеханизмЧтения = Новый ЧтениеXML;
	МеханизмЧтения.ОткрытьФайл(Результат.ПутьКФайлу);
	Построитель = Новый ПостроительDOM;
	
	Документ = Построитель.Прочитать(МеханизмЧтения);

	МеханизмЧтения.Закрыть();
	
	Результат.Вставить("таблицаСвойстваWSDL", таблицаСвойстваWSDL);
	Результат.Вставить("Документ", Документ);
	
КонецПроцедуры

#КонецОбласти

