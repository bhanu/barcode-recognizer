require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ScannerController < Rho::RhoController
  include BrowserHelper

  # GET /Scanner
  def index
  end

  # GET /Scanner/new
  def new
    Camera::take_picture(url_for :action => :camera_callback)
    redirect :action => :index
  end

  def camera_callback
    barcode = Barcode::barcode_recognize(Rho::RhoApplication::get_blob_path(@params['image_uri']))
    show_barcode_info(barcode)
    WebView.navigate(url_for :action => :index)
    ""
  end

  def show_barcode_info(recognized_code)
    Alert.show_popup('Barcode['+recognized_code+']')
  end

  def edit
  end

  def scan_barcode
      Barcode.take_barcode(url_for :action => :scan_barcode_callback)
      redirect :action => :index
  end 

  def scan_barcode_callback
      status = @params['status']
      barcode = @params['barcode']

      puts 'BarcodeRecognizer::take_callback !'
      puts 'status = '+status.to_s unless status == nil 
      puts 'barcode = '+barcode.to_s unless barcode == nil 

      if status == 'ok'
           show_barcode_info(barcode)
      end 
      if status == 'cancel'
           Alert.show_popup('Barcode taking was canceled !')
      end 
      redirect :action => :index
  end 

  def scan1
    barcode = Barcode.barcode_recognize(File.join(Rho::RhoApplication::get_model_path('public','images'), 'Barcode_UPC_01.png'))
    show_barcode_info (barcode)
    redirect :action => :index
  end

  def scan2
    barcode = Barcode.barcode_recognize(File.join(Rho::RhoApplication::get_model_path('public','images'), 'Barcode_UPC_02.jpg'))
    show_barcode_info (barcode)
    redirect :action => :index
  end

  def scan3
    barcode = Barcode.barcode_recognize(File.join(Rho::RhoApplication::get_model_path('public','images'), 'Barcode_QR_01.png'))
    show_barcode_info (barcode)
    redirect :action => :index
  end

end
