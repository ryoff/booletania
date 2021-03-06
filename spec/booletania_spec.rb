require 'spec_helper'

class Invitation < ActiveRecord::Base
  include Booletania
  booletania_columns :accepted1, :accepted2, :accepted3, :accepted4
end

# not AR
class NotActiveRecord
  def initialize
    self.class.__send__(:include, Booletania)
  end
end

describe Booletania do
  it 'has a version number' do
    expect(Booletania::VERSION).not_to be nil
  end

  context "don't extend AR" do
    subject { NotActiveRecord.new }

    it 'raise ArgumentError' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  describe "#_text" do
    let!(:invitation) { Invitation.create(accepted1: accepted1, accepted2: accepted2, accepted3: accepted3, accepted4: accepted4) }
    let(:accepted1) { true }
    let(:accepted2) { true }
    let(:accepted3) { true }
    let(:accepted4) { true }
    after { Invitation.delete_all }

    shared_examples_for 'translated by :booletania i18n key' do
      context "lang is ja" do
        before { I18n.locale = :ja }

        context "column is true" do
          let(:accepted) { true }
          it { is_expected.to eq '承諾' }
        end

        context "column is false" do
          let(:accepted) { false }
          it { is_expected.to eq '拒否' }
        end
      end

      context "lang is en" do
        before { I18n.locale = :en }

        context "column is true" do
          let(:accepted) { true }
          it { is_expected.to eq 'accept' }
        end

        context "column is false" do
          let(:accepted) { false }
          it { is_expected.to eq 'deny' }
        end
      end

      context "lans is invalid" do
        before { I18n.locale = :xx }
        let(:accepted) { true }

        it { is_expected.to eq 'True' }
      end
    end

    shared_examples_for 'translated by :activerecord i18n key' do
      context "lang is ja" do
        before { I18n.locale = :ja }

        context "column is true" do
          let(:accepted) { true }
          it { is_expected.to eq '許可' }
        end

        context "column is false" do
          let(:accepted) { false }
          it { is_expected.to eq '不可' }
        end
      end

      context "lang is en" do
        before { I18n.locale = :en }

        context "column is true" do
          let(:accepted) { true }
          it { is_expected.to eq 'ok' }
        end

        context "column is false" do
          let(:accepted) { false }
          it { is_expected.to eq 'ng' }
        end
      end

      context "lans is invalid" do
        before { I18n.locale = :xx }
        let(:accepted) { true }

        it { is_expected.to eq 'True' }
      end
    end

    describe "#accepted1_text. has only a :booletania i18n key" do
      subject { invitation.accepted1_text }
      let(:accepted1) { accepted }
      it_behaves_like 'translated by :booletania i18n key'
    end

    describe "#accepted2_text. has :booletania and :activerecord i18n keys" do
      subject { invitation.accepted2_text }
      let(:accepted2) { accepted }
      it_behaves_like 'translated by :booletania i18n key'
    end

    describe "#accepted3_text. has only a :activerecord i18n key" do
      subject { invitation.accepted3_text }
      let(:accepted3) { accepted }
      it_behaves_like 'translated by :activerecord i18n key'
    end

    describe "#accepted4_text. do not have any i18n keys" do
      subject { invitation.accepted4_text }

      context "column is true" do
        let(:accepted4) { true }
        it { is_expected.to eq 'True' }
      end

      context "column is false" do
        let(:accepted4) { false }
        it { is_expected.to eq 'False' }
      end
    end
  end

  describe "._options" do
    shared_examples_for 'translated by :booletania i18n key' do
      context "lang is ja" do
        before { I18n.locale = :ja }
        it { is_expected.to eq [['承諾', true], ['拒否', false]] }
      end

      context "lang is en" do
        before { I18n.locale = :en }
        it { is_expected.to eq [['accept', true], ['deny', false]] }
      end

      context "lans is invalid" do
        before { I18n.locale = :xx }
        it { is_expected.to eq [] }
      end
    end

    shared_examples_for 'translated by :activerecord i18n key' do
      context "lang is ja" do
        before { I18n.locale = :ja }
        it { is_expected.to eq [['許可', true], ['不可', false]] }
      end

      context "lang is en" do
        before { I18n.locale = :en }
        it { is_expected.to eq [['ok', true], ['ng', false]] }
      end

      context "lans is invalid" do
        before { I18n.locale = :xx }
        it { is_expected.to eq [] }
      end
    end

    describe ".accepted1_options. has only a :booletania i18n key" do
      subject { Invitation.accepted1_options }
      it_behaves_like 'translated by :booletania i18n key'
    end

    describe ".accepted2_options. has :booletania and :activerecord i18n keys" do
      subject { Invitation.accepted2_options }
      it_behaves_like 'translated by :booletania i18n key'
    end

    describe ".accepted3_options. has only a :activerecord i18n key" do
      subject { Invitation.accepted3_options }
      it_behaves_like 'translated by :activerecord i18n key'
    end

    describe ".accepted4_options. do not have any i18n keys" do
      subject { Invitation.accepted4_options }

      context "lang is ja" do
        before { I18n.locale = :ja }
        it { is_expected.to eq [] }
      end

      context "lang is en" do
        before { I18n.locale = :en }
        it { is_expected.to eq [] }
      end

      context "lans is invalid" do
        before { I18n.locale = :xx }
        it { is_expected.to eq [] }
      end
    end
  end
end
