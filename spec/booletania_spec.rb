require 'spec_helper'

class Invitation < ActiveRecord::Base
  include Booletania
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

  describe "_text" do
    let!(:invitation) { Invitation.create(acceptable: acceptable) }
    after { Invitation.delete_all }

    subject { invitation.acceptable_text }

    context "ja" do
      before { I18n.locale = :ja }

      context "column is true" do
        let(:acceptable) { true }

        it { is_expected.to eq '承諾' }
      end

      context "column is false" do
        let(:acceptable) { false }

        it { is_expected.to eq '拒否' }
      end
    end

    context "en" do
      before { I18n.locale = :en }

      context "column is true" do
        let(:acceptable) { true }

        it { is_expected.to eq 'accept' }
      end

      context "column is false" do
        let(:acceptable) { false }

        it { is_expected.to eq 'deny' }
      end
    end
  end
end
