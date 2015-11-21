require 'spec_helper'

class Post < ActiveRecord::Base
end

describe Booletania do
  it 'has a version number' do
    expect(Booletania::VERSION).not_to be nil
  end

  context 'try spec' do
    let!(:post) { Post.create(acceptable: acceptable) }
    after { Post.delete_all }

    let(:acceptable) { true }

    it { expect(post.acceptable).to be true }
  end
end
