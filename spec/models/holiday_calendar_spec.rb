require 'rails_helper'

RSpec.describe HolidayCalendar, type: :lib do
  describe '.start_week_day' do
    subject { HolidayCalendar.start_week_day(date) }

    context '月曜日が祝日ではない場合' do
      # NOTE: 2016年10月24日(月) は平日
      let(:date) { Date.new(2016, 10, 26) }

      it '月曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 10, 24)
      end
    end

    context '月曜日が祝日の場合' do
      # NOTE: 2016年10月10日(月) は祝日
      let(:date) { Date.new(2016, 10, 12) }

      it '火曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 10, 11)
      end
    end

    context '月曜日から祝日が続いている場合' do
      # NOTE: 2015年05月04日(月) ~ 2015年05月06日(水) は祝日
      let(:date) { Date.new(2015, 5, 6) }

      it '１番最初の平日を返す' do
        expect(subject).to eq Date.new(2015, 5, 7)
      end
    end
  end
end
