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

  describe '.end_week_day' do
    subject { HolidayCalendar.end_week_day(date) }

    context '金曜日が祝日ではない場合' do
      # NOTE: 2016年10月28日(金) は平日
      let(:date) { Date.new(2016, 10, 26) }

      it '金曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 10, 28)
      end
    end

    context '金曜日が祝日の場合' do
      # NOTE: 2016年12月23日(金) は祝日
      let(:date) { Date.new(2016, 12, 21) }

      it '木曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 12, 22)
      end
    end

    context '金曜日から祝日が続いている場合' do
      # NOTE: 2017年05月03日(水) ~ 2017年05月05日(金) は祝日
      let(:date) { Date.new(2017, 5, 4) }

      it '１番最初の平日を返す' do
        expect(subject).to eq Date.new(2017, 5, 2)
      end
    end
  end

  describe '.next_start_week_day' do
    subject { HolidayCalendar.next_start_week_day(date) }

    context '月曜日が祝日ではない場合' do
      # NOTE: 2016年10月24日(月) は平日
      let(:date) { Date.new(2016, 10, 19) }

      it '来週の月曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 10, 24)
      end
    end

    context '月曜日が祝日の場合' do
      # NOTE: 2016年10月10日(月) は祝日
      let(:date) { Date.new(2016, 10, 5) }

      it '来週の火曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 10, 11)
      end
    end

    context '月曜日から祝日が続いている場合' do
      # NOTE: 2015年05月04日(月) ~ 2015年05月06日(水) は祝日
      let(:date) { Date.new(2015, 4, 30) }

      it '来週の１番最初の平日を返す' do
        expect(subject).to eq Date.new(2015, 5, 7)
      end
    end
  end

  describe '.end_week_day' do
    subject { HolidayCalendar.next_end_week_day(date) }

    context '金曜日が祝日ではない場合' do
      # NOTE: 2016年10月28日(金) は平日
      let(:date) { Date.new(2016, 10, 19) }

      it '来週の金曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 10, 28)
      end
    end

    context '金曜日が祝日の場合' do
      # NOTE: 2016年12月23日(金) は祝日
      let(:date) { Date.new(2016, 12, 14) }

      it '来週の木曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 12, 22)
      end
    end

    context '金曜日から祝日が続いている場合' do
      # NOTE: 2017年05月03日(水) ~ 2017年05月05日(金) は祝日
      let(:date) { Date.new(2017, 4, 27) }

      it '来週の１番最初の平日を返す' do
        expect(subject).to eq Date.new(2017, 5, 2)
      end
    end
  end

  describe '.last_start_week_day' do
    subject { HolidayCalendar.last_start_week_day(date) }

    context '月曜日が祝日ではない場合' do
      # NOTE: 2016年10月24日(月) は平日
      let(:date) { Date.new(2016, 11, 2) }

      it '先週の月曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 10, 24)
      end
    end

    context '月曜日が祝日の場合' do
      # NOTE: 2016年10月10日(月) は祝日
      let(:date) { Date.new(2016, 10, 19) }

      it '先週の火曜日の日付が返る' do
        expect(subject).to eq Date.new(2016, 10, 11)
      end
    end

    context '月曜日から祝日が続いている場合' do
      # NOTE: 2015年05月04日(月) ~ 2015年05月06日(水) は祝日
      let(:date) { Date.new(2015, 5, 13) }

      it '先週の１番最初の平日を返す' do
        expect(subject).to eq Date.new(2015, 5, 7)
      end
    end
  end
end
